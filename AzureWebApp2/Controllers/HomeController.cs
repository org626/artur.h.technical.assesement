using System.Diagnostics;
using Microsoft.AspNetCore.Mvc;
using AzureWebApp2.Models;

namespace AzureWebApp2.Controllers;

public class HomeController : Controller
{
    private readonly ILogger<HomeController> _logger;

    public HomeController(ILogger<HomeController> logger)
    {
        _logger = logger;
    }

    public IActionResult Index()
    {
        return View();
    }

}
