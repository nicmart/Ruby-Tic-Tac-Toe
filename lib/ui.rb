class Ui

  def initialize(stdin, stdout)
    @stdin = stdin
    @stdout = stdout
  end

  LOGO = %q!
  __  __  _____ ___ ___   _____ _   ___   _____ ___  ___     ___
  \ \/ / |_   _|_ _/ __| |_   _/_\ / __| |_   _/ _ \| __|   / _ \
   >  <    | |  | | (__    | |/ _ \ (__    | || (_) | _|   | (_) |
  /_/\_\   |_| |___\___|   |_/_/ \_\___|   |_| \___/|___|   \___/
  !

  def welcome
    @stdout.puts "Welcome to..."
  end

  def print_logo
    @stdout.puts LOGO
  end

  def print_grid(grid)
    grid.grid_display[0..-2].each do |array|
      @stdout.puts array.join("  |  ") << "\n_____________"
    end
    @stdout.puts grid.grid_display.last.join("  |  ")
    @stdout.puts "\n"
  end

  def choose_opponent
    @stdout.puts "Choose your opponent: h --> human player, c --> computer"
    opponent_choice = @stdin.gets.chomp.downcase
    while opponent_choice != "h" && opponent_choice != "c"
      opponent_choice = repeat_opponent_choice
    end
    opponent_choice
  end

  def ask_for_move(grid, player_mark)
    @stdout.puts "Player #{player_mark}, make your move:"
    move = @stdin.gets.chomp
    while !grid.grid_numbers.include?(move)
      move = repeat_move
    end
    move
  end

  def ask_for_empty_position
    @stdout.puts "Position already occupied, please move again:"
    @stdin.gets.chomp
  end

  def declare_winner(player_mark)
    @stdout.puts "Player #{player_mark} wins!"
  end

  def declare_draw
    @stdout.puts "It's a draw: nobody wins!"
  end

  private

  def repeat_opponent_choice
    @stdout.puts "Sorry, I didn't understand: h --> human player, c --> computer"
    @stdin.gets.chomp.downcase
  end

  def repeat_move
    @stdout.puts "Move not valid, please repeat your move:"
    @stdin.gets.chomp
  end

end
