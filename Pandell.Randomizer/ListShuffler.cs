
namespace Pandell.Randomizer {
    using System;
    using System.Collections.Generic;

    public class ListShuffler {

        static readonly Random Rand = new Random(Guid.NewGuid().GetHashCode());

        public List<int> Shuffle(List<int> sequentialList) {
            var shuffledList = new List<int>();

            // the sequentialList collection must contain 10000 records.
            if (sequentialList.Count != 10000)
            {
                throw new ArgumentOutOfRangeException("sequentialList", "Collection must contain 10000 records.");
            }

            // This is where all the magic happens. Essentially I'm looping
            // through the sequentialList and generating a random number between
            // 0 and the count of the list. From there I add whatever number is
            // at the index location of the random number, and put it to the top
            // of the shuffledList. I then remove that number from the
            // sequentialList so that it cannot be used again. Each iteration
            // of the loop shrinks the count size by 1 until there is nothing
            // left.
            for (var i = sequentialList.Count; i > 0; i--) {
                var index = Rand.Next(0, i);
                shuffledList.Add(sequentialList[index]);
                sequentialList.RemoveAt(index);
            }

            return shuffledList;
        } 


        public List<int> Shuffle() {
            // The task is to return 10000 unique numbers. So I'm just calling
            // the Shuffle(List<Int>) from this overload with a pre-populated
            // sequential list. 
            // NOTE: This method is not really necessary for the
            // task, but it demonstrates the extensibility aspect.
            const int defaultListSize = 10000;
            var sequentialList = new List<int>();

            for (var i = 1; i < defaultListSize + 1; i++) {
                sequentialList.Add(i);
            }

            return this.Shuffle(sequentialList);
        } 

    }
}
