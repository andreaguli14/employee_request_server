using System.Management.Automation;
using System.Diagnostics;
using System.Reflection.PortableExecutable;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using PowershellShowcase;
using System.Collections.Generic;
using static Microsoft.ApplicationInsights.MetricDimensionNames.TelemetryContext;
using System.Diagnostics.Metrics;

namespace backend.Controllers;

[ApiController]
[Route("/adduser")]

public class PowerShellScriptController : ControllerBase

{
    //get member of user
    [HttpGet("{id}")]
    public string Get(string id)
    {
       
        string url = "http://localhost:3000/Emplo"
        return "ciao";


    }



}






