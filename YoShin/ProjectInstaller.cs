using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Configuration.Install;

namespace Edubill.YoShin.YoShinService
{
    [RunInstaller(true)]
    public partial class ProjectInstaller : Installer
    {
        public ProjectInstaller()
        {
            InitializeComponent();
        }
    }
}