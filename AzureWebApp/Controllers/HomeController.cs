using Microsoft.AspNetCore.Mvc;

namespace AzureWebApp.Controllers;

public class HomeController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
}
