##Pandell Random List Programming Solution

####TheTask:

> Please write a program that generates a list of 10,000 numbers in random order each time it is run. Each number in the list must be unique and be between 1 and 10,000 (inclusive).

####Additional Aspects:

> The most important success factor is to produce the best solution you can to solve the problem. There are many aspects to consider within that context - efficiency, performance, documentation, etc. Code to perform the algorithm is the minimum requirement. Your deliverable should contain enough to give us a glimpse into your analysis, your approach, your skills, or anything else that will demonstrate your ability as a software developer. We will be looking for a good approach, a glimpse into your thought process, things you can do to impress us, and clean and efficient code. We're your potential customer for this assignment, show us what you've got.
Your deliverable will be something that we can execute (to test the results), written in C# along with whatever explanation of the code/program that you feel is necessary.

####The Solution:

> The approach I took with this task was to write a method that performs well and passes a gauntlet of tests designed to prove that it adheres to "The Task".

The tests check that the list contains numbers within the specified range, that the list returns exactly the right number of records, and that each run of the program generates truely random results (as subjective as that is within the realm of programming). It also tests to ensure that the `ArguementOutOfRangeException` is thrown when an invalid `List<int>` is passed.

The method it's self was quite fun to come up with. Using a `List<int>` to store the numbers makes it incredibly easy to remove a random number from the sequential list and place it at the top of the shuffled list (much like a game of jenga). As the sequential list gets smaller, the "shuffler" adapts so that it always grabs from an index location as opposed to searching for the actual `int`.

    for (var i = sequentialList.Count; i > 0; i--) {
        var index = Rand.Next(0, i);
        shuffledList.Add(sequentialList[index]);
        sequentialList.RemoveAt(index);
    }

####The Build:

No project is complete without a nice build script to build the solution, run the tests and ouput the results. This build script has a couple of dependencies required to run on the local computer. The first is that the project requires .NET 4.0 to be installed. It was originally built with .NET 4.5, but after realizing that many shops are using v4.5 yet, I adjusted the properties to use v4.0. Second, with the thought that this project "might" be run on a computer that doesn't have Visual Studio installed, I included an open source project called [Gallio][1] in the `build_tools` directory. This project helps me run the tests without the need for `MSTest.exe` which ships with Visual Studio.

So fire up Powershell and run the `build.ps1` to see the builds compile, tests run, and output be generated. All in the hopes that it'll pass.

Thanks for taking the time to consider my solution.  
Chase

 [1]: http://gallio.org