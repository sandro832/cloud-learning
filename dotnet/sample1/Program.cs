using System;

namespace sample1
{
    class Program
    {
        static void Main(string[] args)
        {
            var eins = new Auto();
            eins.Name = "Audi";
            Auto.Felgen = 101;

            var zwei = new Auto();
            zwei.Name = "VW";
            
            Console.WriteLine(eins.Name);
            Console.WriteLine(zwei.Name);
            Console.WriteLine(Auto.Felgen);
            Console.WriteLine(Auto.Felgen);

        }
    }
}
