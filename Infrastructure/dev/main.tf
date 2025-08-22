resource "azurerm_resource_group" "rga" {
  name     = var.resource_group_name
  location = var.resource_group_location
}

resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  resource_group_name = azurerm_resource_group.rga.name
  location            = azurerm_resource_group.rga.location
  os_type             = "Linux"
  sku_name            = var.service_plan_sku_name
  depends_on = [
    azurerm_resource_group.rga
  ]

}

resource "azurerm_linux_web_app" "app" {
  name                = var.linux_web_app_name
  resource_group_name = azurerm_resource_group.rga.name
  location            = azurerm_service_plan.asp.location
  service_plan_id     = azurerm_service_plan.asp.id

  site_config {
    always_on = true

    # application_stack {
    #   docker_image_name   = "nginx:latest"
    # }
  }

  app_settings = {
    "DATABASE_URL"                        = "postgresql://${azurerm_postgresql_flexible_server.server.administrator_login}:${azurerm_postgresql_flexible_server.server.administrator_password}@${azurerm_postgresql_flexible_server.server.fqdn}:5432/${azurerm_postgresql_flexible_server_database.db.name}?sslmode=require"
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  depends_on = [
    azurerm_service_plan.asp,
    azurerm_postgresql_flexible_server.server,
    azurerm_postgresql_flexible_server_database.db
  ]

}

resource "azurerm_postgresql_flexible_server" "server" {
  name                   = var.postgresql_flexible_server_name
  resource_group_name    = azurerm_resource_group.rga.name
  location               = azurerm_resource_group.rga.location
  version                = "12"
  administrator_login    = "psqladmin"
  administrator_password = "H@Sh1CoR3!"
  storage_mb             = 32768
  sku_name               = "GP_Standard_D4s_v3"

  # Configure for private access
  delegated_subnet_id           = azurerm_subnet.backend.id
  private_dns_zone_id           = azurerm_private_dns_zone.postgres.id
  public_network_access_enabled = false

  depends_on = [
    azurerm_resource_group.rga,
    azurerm_subnet.backend,
    azurerm_private_dns_zone_virtual_network_link.postgres
  ]

}

resource "azurerm_postgresql_flexible_server_database" "db" {
  name      = var.postgresql_flexible_server_database_name
  server_id = azurerm_postgresql_flexible_server.server.id
  collation = "en_US.utf8"
  charset   = "UTF8"

  # prevent the possibility of accidental data loss
  # lifecycle {
  #   prevent_destroy = true
  # }

  depends_on = [
    azurerm_postgresql_flexible_server.server
  ]

}


resource "azurerm_virtual_network" "vnet" {
  name                = var.virtual_network_name
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rga.location
  resource_group_name = azurerm_resource_group.rga.name
}

resource "azurerm_subnet" "frontend" {
  name                 = var.frontend_subnet_name
  resource_group_name  = azurerm_resource_group.rga.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.1.0/24"]

  delegation {
    name = "webapp-delegation"
    service_delegation {
      name    = "Microsoft.Web/serverFarms"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]

}

resource "azurerm_subnet" "backend" {
  name                 = var.backend_subnet_name
  resource_group_name  = azurerm_resource_group.rga.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = ["10.0.2.0/24"]

  delegation {
    name = "postgresql-delegation"
    service_delegation {
      name    = "Microsoft.DBforPostgreSQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }

  depends_on = [
    azurerm_virtual_network.vnet
  ]

}

# Private DNS Zone for PostgreSQL
resource "azurerm_private_dns_zone" "postgres" {
  name                = var.private_dns_zone_name
  resource_group_name = azurerm_resource_group.rga.name

  depends_on = [
    azurerm_resource_group.rga
  ]
}

# Link Private DNS Zone to VNet
resource "azurerm_private_dns_zone_virtual_network_link" "postgres" {
  name                  = var.private_dns_zone_virtual_network_link_name
  resource_group_name   = azurerm_resource_group.rga.name
  private_dns_zone_name = azurerm_private_dns_zone.postgres.name
  virtual_network_id    = azurerm_virtual_network.vnet.id

  depends_on = [
    azurerm_private_dns_zone.postgres,
    azurerm_virtual_network.vnet
  ]
}

# VNet Integration for App Service
resource "azurerm_app_service_virtual_network_swift_connection" "app_vnet_integration" {
  app_service_id = azurerm_linux_web_app.app.id
  subnet_id      = azurerm_subnet.frontend.id

  depends_on = [
    azurerm_linux_web_app.app,
    azurerm_subnet.frontend
  ]
}
