using System;
using System.IO;
using System.Threading;

namespace FileGenerator
{
    class Program
    {
        static void Main(string[] args)
        {
            var maker = new FileMaker(@"c:\temp\test.txt");
            maker.Run();
            maker = new FileMaker(@"c:\temp\test2.txt");
            maker.Run();
        }
    }
}
