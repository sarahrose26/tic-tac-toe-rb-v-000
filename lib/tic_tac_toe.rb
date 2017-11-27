WIN_COMBINATIONS = [
[0,1,2],#top row
[3,4,5],#middle row
[6,7,8],#bottom row
[0,3,6],#left column
[1,4,7],#middle column
[2,5,8],#right column
[0,4,8],#diagonal l to r
[2,4,6]#diagonal r to l
]

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def position_taken?(board, location)
  board[location] != " " && board[location] != ""
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  current_player = gets.strip
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index) != true
    input = gets.strip
  else
    move(board, index, current_player = "X")
  end
  display_board(board)
  # else
  #   turn(board)
  #end
end

def turn_count(board)
  turn = 0
  board.each do |marker|
    if marker == "X" || marker == "O"
      return turn +=1
    end
    return turn
end

def current_player(board)
  player = turn_count(board)
  if player.even?
    return "X"
  else
    return "O"
  end
end

def won? (board)
  WIN_COMBINATIONS.each do |win_combination|
    win_index_1 = win_combination[0]
    win_index_2 = win_combination[1]
    win_index_3 = win_combination[2]

    position_1 = board[win_index_1]
    position_2 = board[win_index_2]
    position_3 = board[win_index_3]

    if [position_1, position_2, position_3].all? {|symbol| symbol == "X"}
      return win_combination
    elsif [position_1, position_2, position_3].all? {|symbol| symbol == "O"}
       return win_combination
     end
   end
   false
 end

 def full?(board)
  !board.include?(" ") #if board does not include a space
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  else
    return false
  end
end

def over?(board)
  if won?(board) || full?(board) || draw?(board)
    return true
  else
    return false
  end
end

def winner(board)
  if WIN_COMBINATIONS.include?(won?(board))
    index = won?(board)[0]
    return board[index]
  end
end

def play(board)
  user_turn = 0
  until user_turn == 9
    user_turn += 1
    turn(board)
  end
end
