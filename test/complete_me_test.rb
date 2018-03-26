require 'simplecov'
SimpleCov.start
require "minitest"
require "minitest/emoji"
require "minitest/autorun"
require "./lib/complete_me"
require "pry"

class CompleteMeTest < Minitest::Test

  def setup
    @cm = CompleteMe.new
  end

<<<<<<< HEAD
=======

  #METHODS
  def insert_words(words)
    @cm.populate(words.join("\n"))

  end

  # def medium_word_list
  #   File.read('../complete_me/complete_me_spec_harness/test/medium.txt')
  # end

  # def large_word_list
  #   File.read('/usr/share/dict/words')
  # end

>>>>>>> 9cd4a448fdef4653f18c4fd3136f85f997ec00d7
  def test_count_starts_at_zero
    skip
    expected = 0
    assert_equal expected, @cm.count
  end

  def test_it_inserts_a_word
    skip
    @cm.insert('hedgehog')
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
    strings = File.read('./lib/word_list.txt')
    expected_1 = 'cascade'
    expected_2 = 'monday'
    expected_3 = 15
    assert_equal expected_1, @cm.populate(strings).first
    assert_equal expected_2, @cm.populate(strings).last
    assert_equal expected_3, @cm.populate(strings).count
  end

  def test_populate_inserts_strings_into_trie
    skip
    strings = File.read('./lib/word_list.txt')
    @cm.populate(strings)
    assert @cm.search('basement')
  end

  def test_suggest_returns_final_word_suggestions
    skip
    prefix = "a"
    insert_words(["am", "at", "banana"])
    expected = ["am", "at"]
    assert_equal expected, @cm.suggest(prefix).sort
  end

<<<<<<< HEAD
=======
#Search is not taking arguments and returning has_key? false for
#"lcjkadsd" as expected
  # def test_search_returns_false_if_word_not_in_trie
  # refute @cm.search('lcjkadsd')
  # end

>>>>>>> 9cd4a448fdef4653f18c4fd3136f85f997ec00d7
  def test_search_returns_false_if_word_not_in_trie
    skip
    node = @cm.search("lcjkadsd")
  end

  def test_unknown_prefix_is_not_a_word
    skip
    @cm.insert("hello")
    node = @cm.search("hell")
    refute node.word_flag
  end

  def test_it_can_detect_it_includes_a_word
    skip
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    assert @cm.include?("hedgehog")
  end

  def test_it_can_delete_a_word
    skip
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    @cm.delete("hedgehog")
    refute @cm.include?("hedgehog")
  end

  def test_it_deletes_non_word_nodes_on_word_delete
    skip
    insert_words(["actual", "act"])
    @cm.delete("actual")
    refute @cm.search("actua")
    assert @cm.include?("act")
  end

  def test_count_can_go_down
    skip
    insert_words(["actual", "act"])
    expected = 1
    assert_equal expected, @cm.delete("act")
  end

<<<<<<< HEAD
  #METHODS
  def insert_words(words)
    @cm.populate(words.join("\n"))

  end

  def medium_word_list
    File.read('../complete_me/complete_me_spec_harness/test/medium.txt')
  end

  def large_word_list
    File.read('/usr/share/dict/words')
  end

  def test_read_CSV
    tree = CompleteMe.new
    tree.read_CSV_file
  end

  def test_it_inserts_the_CSV_list_correctly
    @cm.read_CSV_file
    assert @cm.search("8110 E Union Ave Spc PK1043")
    assert @cm.search("8110 ")
    @cm.select("8110", "8110 E Union Ave Spc PK1043")
    assert_equal "8110 E Union Ave Spc PK1043", @cm.suggest("8110").first

    assert_equal "8110 E Union Ave Spc PK1043", @cm.suggest("8110 E Union Ave Spc PK104")
=======
  def test_it_can_check_inclusion_of_a_word
    skip
    insert_words(["actual", "act"])
    assert @cm.include?("actual")
    refute @cm.include?("beowulf")
>>>>>>> 9cd4a448fdef4653f18c4fd3136f85f997ec00d7
  end

  def test_it_inserts_the_CSV_list_correctly
    @cm.read_CSV_file
    assert @cm.search("8110 E Union Ave Spc PK1043")
    assert @cm.search("8110 ") 
    @cm.select("8110", "8110 E Union Ave Spc PK1043")
    assert_equal "8110 E Union Ave Spc PK1043", @cm.suggest("8110").first
    
    assert_equal "8110 E Union Ave Spc PK1043", @cm.suggest("8110 E Union Ave Spc PK104")
  end



end
