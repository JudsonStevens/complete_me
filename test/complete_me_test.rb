require "minitest"
require "minitest/emoji"
require "minitest/autorun"
require "./lib/complete_me"
require "pry"

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

  #METHODS
  def insert_words(words)
    @cm.populate(words.join("\n"))
  end

  def medium_word_list
    File.read("../complete_me/complete_me_spec_harness/test/medium.txt")
  end

  def large_word_list
    File.read("/usr/share/dict/words")
  end

  def test_count_starts_at_zero
    skip
    expected = 0
    assert_equal expected, @cm.count
  end

  def test_it_inserts_a_word
    skip
    @cm.insert("hedgehog")
    expected = 1
    assert_equal expected, @cm.count
  end

  def test_it_inserts_multiple_words
    skip
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    expected = 4
    assert_equal expected, @cm.count
  end


  def test_populate_returns_an_array_of_strings
    skip
    strings = File.read("./complete_me_spec_harness/test/medium.txt")
    expected_1 = "southbound"
    expected_2 = "mastoncus"
    expected_3 = 1000
    assert_equal expected_1, @cm.populate(strings).first
    assert_equal expected_2, @cm.populate(strings).last
    assert_equal expected_3, @cm.populate(strings).count
  end

  def test_populate_inserts_strings_into_trie
    skip
    strings = File.read("./complete_me_spec_harness/test/medium.txt")
    @cm.populate(strings)
    assert @cm.search("bullfinch")
  end

  def test_suggest_returns_final_word_suggestions
    skip
    prefix = "a"
    insert_words(["am", "at", "banana"])
    expected = ["am", "at"]
    assert_equal expected, @cm.suggest(prefix).sort
  end

  def test_search_returns_false_if_word_not_in_trie
    skip
    refute @cm.search("lcjkadsd")
  end

  def test_unknown_prefix_is_not_a_word
    skip
    @cm.insert("hello")
    # binding.pry
    refute @cm.search("hell")
  end

  def test_it_can_delete_a_word
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    actual = @cm.include?("hedgehog")
    expected = true
    assert_equal expected, actual
    @cm.delete("hedgehog")
    refute @cm.include?("hedgehog")
    
    
  end


  # def test_word_flag_starts_false
  #   assert word_flag.false?
  # end

  # def test_word_flag_can_be_set_to_true

  # end

end
