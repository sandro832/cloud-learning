//Librarys which are used in the program
using System;
using System.IO;
using System.Threading;

namespace FileGenerator
{
    class FileMaker
    {
        //Variable for the logfile
        string logfile;
        int cooldown;

        //Constructor
        public FileMaker(string filename = "")
        {
            if (string.IsNullOrEmpty(filename))
            {
                DefineLogFile();
            }
            else 
            { 
                logfile = filename; 
            }
            cooldown = 10;
        }

        //Sets the variable to Test.log. Generates output saying that the Program is writing to logfile.
        public void Run()
        {
            DisplayLogFileExists();
            DeleteLogFile();
            CreateLogFile();
            GenerateData();
        }
        public void DefineLogFile()
        {
            var filename = "Test.log";
            Console.WriteLine($"Program is writing to {filename}");
            logfile = Path.Combine(@"c:\temp", filename);
        }

        // Checks Folder if there is a file named logfile and returns true or false
        public void DisplayLogFileExists()
        {
            Console.WriteLine(File.Exists(logfile));
        }

        // If there is already a file named logfile it gets deleted and you get the output "File is deleted. 
        public void DeleteLogFile()
        {
            if (File.Exists(logfile))
            {
                File.Delete(logfile);
                Console.WriteLine("File is deleted");
            }
        }

        //Creationg of the file and creates a line with the current time and Date.
        public void CreateLogFile()
        {
            using (StreamWriter sw = File.CreateText(logfile))
            {
                sw.WriteLine(DateTime.Now);
            }

        }
        public void GenerateData()
        {
            var i = 1;
            while (i <= 60)
            {
                Console.Write(".");
                i++;

                using (StreamWriter sw = File.AppendText(logfile))
                {
                    sw.WriteLine(DateTime.Now);
                }

                Thread.Sleep(cooldown);
            }
        }
    }
}
