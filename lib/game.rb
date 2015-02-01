require_relative 'player'
require_relative 'deck'

class Game
  attr_reader :deck, :pot

  def initialize(players)
    @players = []
    players.times { |i| @players << Player.new( "Player#{i+1}", 100) }
    @deck = Deck.new
    @pot = 0
  end

  def play
    puts "Welcome to 5-card draw in Ruby!"
    hand_counter = 1
    until @players.count == 1
      puts "XXXX HAND ##{hand_counter} XXXX"
      hand_counter += 1
      hand_of_poker
      @players.reject! { |player| player.bankroll == 0}
    end
    puts "Congratulations, #{@players.first.name} is the winner!"
  end

  def deal(player, num_cards)
    player.hand.hold(deck.draw(num_cards))
  end

  # !! does not handle ties/split pots !! #
  def hand_of_poker
    players_in_hand = @players.dup
    @players.each {|player| deal(player, 5)}
    remaining_players = betting_round(players_in_hand)
    unless remaining_players.count == 1
      exchange_cards
      remaining_players = betting_round(remaining_players)
      unless remaining_players.count == 1
        remaining_players = compare_hands(remaining_players)
      end
    end
    winner = remaining_players.first
    puts "#{winner.name} wins!"
    print "\n\n\n"
    pay_out(winner)
    reset_deck
  end

  # !! does not account for players who are all in !!
  def betting_round(players_in_hand)
    players_in_hand.each { |player| player.called = false }
    current_bet = 0

    #loops through players until betting is resolved
    until players_in_hand.all? { |player| player.called? }
      bettor = players_in_hand.shift
      bet = bettor.get_bet(current_bet - bettor.already_bet)
      case bet
      when :fold
        puts "#{bettor.name} folds."
      when :call
        @pot += current_bet - (bettor.already_bet - current_bet)
        puts "#{bettor.name} calls (#{current_bet})."
        bettor.called = true
        players_in_hand << bettor
      else
        puts "#{bettor.name} raises to #{bet}!"
        @pot += bet
        current_bet = bet
        players_in_hand.each { |player| player.called = false }
        bettor.called = true
        players_in_hand << bettor
      end
    end

    @players.each { |player| player.already_bet = 0 }
    players_in_hand
  end

  def exchange_cards
    @players.each do |player|
      discarded_cards = player.discard
      deck.return(discarded_cards)
      deal(player, discarded_cards.count)
    end
  end

  def compare_hands(players)
    until players.count == 1
      player1, player2 = players[0], players[1]
      case player1.hand.compare(player2.hand)
      when player1.hand then players.delete(player2)
      when player2.hand then players.delete(player1)
      when nil then players.push(players.shift)
      end
    end
    players
  end

  def reset_deck
    @players.each do |player|
      deck.return(player.hand.cards)
      player.hand.cards = []
    end
    deck.shuffle
  end

  def pay_out(player)
    player.bankroll += @pot
    @pot == 0
  end
end
