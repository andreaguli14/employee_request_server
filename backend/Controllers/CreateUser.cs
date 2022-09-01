using System.Diagnostics;
using System.Reflection.PortableExecutable;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Diagnostics.Metrics;
namespace backend.Controllers;

[ApiController]
[Route("/createuser")]

public class CreateUser : ControllerBase

{
    //get member of user
    [HttpGet("{id}")]
    public string Get(string id)
    {
        
        string command = "/c C:\\Users\\internpn\\Desktop\\employee_request_server-main\\powershell_script\\adduser.ps1 " + id;
        System.Diagnostics.Process si = new System.Diagnostics.Process();
        si.StartInfo.WorkingDirectory = "c:\\";
        si.StartInfo.UseShellExecute = false;
        si.StartInfo.FileName = "powershell.exe";
        si.StartInfo.Arguments = command;
        si.StartInfo.CreateNoWindow = true;
        si.StartInfo.RedirectStandardInput = true;
        si.StartInfo.RedirectStandardOutput = true;
        si.StartInfo.RedirectStandardError = true;
        si.Start();
        string output = si.StandardOutput.ReadToEnd();
        si.Close();

        return output;


    }



}






