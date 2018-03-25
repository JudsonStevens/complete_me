require "minitest"
require "minitest/emoji"
require "minitest/autorun"
require "./lib/complete_me"

class CompleteMeTest < Minitest::Test

  def setup
    @cm = CompleteMe.new
  end

  #SPEC HARNESS
  # def test_starting_count
  #   assert_equal 0, cm.count
  # end
  #
  # def test_inserts_single_word
  #   cm.insert("pizza")
  #   assert_equal 1, cm.count
  # end
  #
  # def test_inserts_multiple_words
  #   cm.populate("pizza\ndog\ncat")
  #   assert_equal 3, cm.count
  # end
  #
  # def test_counts_inserted_words
  #   insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
  #   assert_equal 5, cm.count
  # end
  #
  # def test_suggests_off_of_small_dataset
  #   insert_words(["pizza", "aardvark", "zombies", "a", "xylophones"])
  #   assert_equal ["pizza"], cm.suggest("p")
  #   assert_equal ["pizza"], cm.suggest("piz")
  #   assert_equal ["zombies"], cm.suggest("zo")
  #   assert_equal ["a", "aardvark"], cm.suggest("a").sort
  #   assert_equal ["aardvark"], cm.suggest("aa")
  # end
  #
  # def test_inserts_medium_dataset
  #   cm.populate(medium_word_list)
  #   assert_equal medium_word_list.split("\n").count, cm.count
  # end
  #
  # def test_suggests_off_of_medium_dataset
  #   cm.populate(medium_word_list)
  #   assert_equal ["williwaw", "wizardly"], cm.suggest("wi").sort
  # end
  #
  # def test_selects_off_of_medium_dataset
  #   cm.populate(medium_word_list)
  #   cm.select("wi", "wizardly")
  #   assert_equal ["wizardly", "williwaw"], cm.suggest("wi")
  # end
  #
  # def test_works_with_large_dataset
  #   cm.populate(large_word_list)
  #   assert_equal ["doggerel", "doggereler", "doggerelism", "doggerelist", "doggerelize", "doggerelizer"], cm.suggest("doggerel").sort
  #   cm.select("doggerel", "doggerelist")
  #   assert_equal "doggerelist", cm.suggest("doggerel").first
  # end

  # #METHODS
  # def insert_words(words)
  #   cm.populate(words.join("\n"))
  # end
  #
  # def medium_word_list
  #   File.read("../complete_me/complete_me_spec_harness/test/medium.txt")
  # end
  #
  # def large_word_list
  #   File.read("/usr/share/dict/words")
  # end

  def test_populate_returns_an_array_of_strings
    File.read("./test/medium.txt")
    expected = "southbound"
    assert_equal expected, @cm.populate(strings).first 
  end

  def test_populate_inserts_strings_into_trie

  end

  def test_suggest_returns_final_word_suggestions

  end

  def test_search_checks_each_node_for_child_node_with_letter

  end

  def test_word_flag_starts_false
    assert word_flag.false?
  end

  def test_word_flag_can_be_set_to_true

  end

end
