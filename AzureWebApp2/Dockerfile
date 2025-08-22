FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS runtime
WORKDIR /app
EXPOSE 80
COPY ./AzureWebApp2/bin/Release/net9.0/publish/ .
ENV ASPNETCORE_URLS=http://+:80
ENTRYPOINT ["dotnet", "AzureWebApp2.dll"]
