namespace Pandell.RandomNumberProblem {
    using Pandell.Randomizer;
    using System;

    class Program {
        static void Main(string[] args) {
            var listShuffler = new ListShuffler();

            // Using the overload method to return the default number of records (10000)
            var shuffledList = listShuffler.Shuffle();

            // iterate through the list and dump the results to the console.
            foreach (var i in shuffledList)
            {
                Console.WriteLine(i);
            }

        }
    }
}
