FROM mcr.microsoft.com/dotnet/aspnet:9.0 AS final
WORKDIR /app
COPY ./AzureWebApp/bin/Release/net9.0/publish/ .
ENV ASPNETCORE_URLS=http://+:80
EXPOSE 80
ENTRYPOINT ["dotnet", "AzureWebApp.dll"]