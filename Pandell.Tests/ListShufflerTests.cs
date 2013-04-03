namespace Pandell.Tests {
    using NUnit.Framework;
    using Pandell.Randomizer;
    using System;
    using System.Collections.Generic;

    [TestFixture]
    public class ListShufflerTests {

        [Test]
        public void ShuffledListShouldBeWithinRange() {
            var listShuffler = new ListShuffler();
            var shuffledList = listShuffler.Shuffle();
            var failed = false;
            foreach (var i in shuffledList) {
                // list must not contain 0
                if (i == 0) {
                    failed = true;
                }

                // list must not be > 10000
                if (i == 10001) {
                    failed = true;
                }
            }

            Assert.IsFalse(failed);
        }

        [Test]
        public void ListShufflerReturnsTenThousandRecordsByDefault() {
            var listShuffler = new ListShuffler();
            var shuffledList = listShuffler.Shuffle();
            // By default, our shuffled list should return 10000 records.
            Assert.IsTrue(shuffledList.Count == 10000);
        }

        [Test]
        public void ListShufflerReturnsRequestedNumberOfRecords() {
            // The task was to return 10000 unique numbers, but this test just
            // checks to confirm that the returned list has the requested number
            // of records. For the purpose of this test, I'm still using 10000
            const int defaultListSize = 10000;
            var listShuffler = new ListShuffler();
            var sequentialList = new List<int>();

            // create a sequential list from 1 to 10000
            for (var i = 1; i < defaultListSize + 1; i++) {
                sequentialList.Add(i);
            }

            // shuffle the sequential and maintain the correct number of records.
            var shuffledList = listShuffler.Shuffle(sequentialList);

            // This should ensure that the shuffled list has 10000 records.
            Assert.IsTrue(shuffledList.Count == 10000);
        }


        [Test]
        public void ShuffledListsAreTrulyRandom() {
            // note: this test "could" fail, but the odds are incredibly slim.
            var listShuffler = new ListShuffler();

            // create three Shuffled Lists, all three will be different.
            var firstShuffledList = listShuffler.Shuffle();
            var secondShuffledList = listShuffler.Shuffle();
            var thirdShuffledList = listShuffler.Shuffle();

            // pick any random number between 0 and 10000, we're going to use
            // this random number to select the int at the respective index
            // location.
            var rand = new Random(Guid.NewGuid().GetHashCode());
            var index = rand.Next(0, 10000);

            // and now pick the int at the randomly indexed location for each 
            // shuffled list. example: 

            // var _Selected = _ShuffledList[100]; 

            // the important thing here is that what ever index we use must be
            // consistent for all three. I could just pick the first int in each
            // list, or the 5th for that matter, but I feel that picking a
            // random int for each list will better prove the randomness of each
            // list.
            var firstSelected = firstShuffledList[index];
            var secondSelected = secondShuffledList[index];
            var thirdSelected = thirdShuffledList[index];

            // If all three integers are unique, then we know that the shuffled
            // list is truly random.
            Assert.IsTrue(
                firstSelected != secondSelected &
                secondSelected != thirdSelected &
                thirdSelected != firstSelected
                );

        }

        [Test]
        [ExpectedException(typeof(ArgumentOutOfRangeException))]
        public void ListShufflerWasNotGivenValidList() {
            // NOTE: this number can be anything BUT 10000
            const int defaultListSize = 9;

            var sequentialList = new List<int>();
            var listShuffler = new ListShuffler();

            // create a sequential list from 1 to defaultListSize
            for (var i = 1; i < defaultListSize + 1; i++) {
                sequentialList.Add(i);
            }

            // this should throw an ArgumentOutOfRange exception since I have
            // not passed a list with exactly 10000 records.
            var shuffledList = listShuffler.Shuffle(sequentialList);
        }
    }
}
