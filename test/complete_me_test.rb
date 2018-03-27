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

  def test_count_starts_at_zero
    expected = 0
    assert_equal expected, @cm.count
  end

  def test_it_inserts_a_word
    @cm.insert('hedgehog')
    expected = 1
    assert_equal expected, @cm.count
  end

  def test_it_inserts_multiple_words
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    expected = 4
    assert_equal expected, @cm.count
  end

  def test_populate_returns_an_array_of_strings
    strings = File.read('./lib/word_list.txt')
    expected_1 = 'cascade'
    expected_2 = 'monday'
    expected_3 = 15
    assert_equal expected_1, @cm.populate(strings).first
    assert_equal expected_2, @cm.populate(strings).last
    assert_equal expected_3, @cm.populate(strings).count
  end

  def test_populate_inserts_strings_into_trie
    strings = File.read('./lib/word_list.txt')
    @cm.populate(strings)
    assert @cm.search('basement')
  end

  def test_suggest_returns_final_word_suggestions
    prefix = "a"
    insert_words(['am', 'at', 'banana'])
    expected = ['am', 'at']
    assert_equal expected, @cm.suggest(prefix).sort
  end

  def test_search_returns_false_if_word_not_in_trie
    node = @cm.search('lcjkadsd')
  end

  def test_unknown_prefix_is_not_a_word
    @cm.insert('hello')
    node = @cm.search('hell')
    refute node.word_flag
  end

  def test_it_can_detect_it_includes_a_word
    insert_words(['porcupine', 'hedgehog', 'capybara', 'ferret'])
    assert @cm.include?('hedgehog')
  end

  def test_it_can_delete_a_word
    insert_words(['porcupine', 'hedgehog', 'capybara', 'ferret'])
    @cm.delete('hedgehog')
    refute @cm.include?('hedgehog')
  end

  def test_it_deletes_non_word_nodes_on_word_delete
    insert_words(['actual', 'act'])
    @cm.delete('actual')
    refute @cm.search('actua')
    assert @cm.include?('act')
  end

  def test_count_can_go_down
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    assert @cm.include?("hedgehog")
  end

  def test_it_can_delete_a_word
    insert_words(["porcupine", "hedgehog", "capybara", "ferret"])
    @cm.delete("hedgehog")
    refute @cm.include?("hedgehog")
  end

  def test_it_deletes_non_word_nodes_on_word_delete
    insert_words(["actual", "act"])
    @cm.delete("actual")
    refute @cm.search("actua")
    assert @cm.include?("act")
  end

  def test_count_can_go_down
    insert_words(["actual", "act"])
    expected = 1
    assert_equal 2, @cm.count
    @cm.delete('act')
    assert_equal expected, @cm.count
  end

  def test_it_can_check_inclusion_of_a_word
    insert_words(['actual', 'act'])
    assert @cm.include?("actual")
    refute @cm.include?("beowulf")
  end

  def test_it_can_search_addresses
    @cm.read_CSV_file
    assert @cm.search('8110 E Union Ave Spc PK1043')
    assert @cm.search('8110 ')
    @cm.select('8110', '8110 E Union Ave Spc PK1043')
    assert_equal '8110 E Union Ave Spc PK1043', @cm.suggest('8110').first
  end

  def test_it_can_make_mid_word_suggestions
    insert_words(['porcupine', 'hedgehog', 'capybara', 'ferret', 'cupacabra'])
    expected = ['cupacabra', 'porcupine']
    actual = @cm.suggest("cup", true)
    assert_equal expected, actual
  end


  def medium_word_list
    File.read('../complete_me/complete_me_spec_harness/test/medium.txt')
  end

  def large_word_list
    File.read('/usr/share/dict/words')
  end
end
