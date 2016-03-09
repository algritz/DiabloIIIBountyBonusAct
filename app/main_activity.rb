class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    puts 'Diablo III Bounty Bonus Acts'
    puts 'Started'
    super
    view = Android::Widget::TextView.new(self)
    view.text = 'Diablo III Bounty Bonus Acts'

    list = Android::Widget::ListView.new(self)
    list.adapter = adapter

    self.contentView = list

  end

  def adapter
    @complete_list = [[5,2,3,1,4],[2,3,1,4,5],[3,1,4,2,5],[1,4,2,5,3],[4,2,1,5,3],[2,1,5,3,4],[1,5,3,4,2],[5,3,4,1,2],[3,4,1,2,5],[4,1,3,2,5],[1,3,2,5,4],[3,2,5,4,1],[2,5,4,3,1],[5,4,3,1,2],[4,3,5,1,2],[3,5,1,2,4],[5,1,2,4,3],[1,2,4,5,3],[2,4,5,3,1],[4,5,2,3,1]]
    current_hour =  Time.now.to_i / 3600
    offset = 6

    puts "#{current_cycle_index = (current_hour + offset) % 20} current index"
    puts "#{next_cycle_index = (current_hour  + offset + 1) % 20} next index"
    puts "#{remaining_cycle_index = (current_hour  + offset + 2) % 20} remaining index"

    if remaining_cycle_index == (@complete_list.count + 1)
      puts "remaining list needs to start at the beginning"
      remaining_cycle_index = 0
    end

    if next_cycle_index == @complete_list.count
      puts "next one in  list needs to start at the beginning"
      next_cycle_index = 0
      remaining_cycle_index = 1
    end

    current_cycle = "Current Cycle | until #{Time.at((Time.now.to_i)).strftime('%H:59:59')} - #{@complete_list[current_cycle_index]}"
    next_cycle =  "Next Cycle | starting #{Time.at((Time.now.to_i + 3600)).strftime('%H:00')} - #{@complete_list[next_cycle_index]}"
    reminder_cycle = []
    restart_cycle = []

    reminder_cycle << @complete_list[remaining_cycle_index .. @complete_list.count]
    
    reminder_cycle = reminder_cycle.first
    
    restart_cycle << @complete_list[0.. current_cycle_index - 1]
    
    puts "#{reminder_cycle.count} remainder count"
    puts reminder_cycle
    
    puts "#{restart_cycle.count} restart count"
    puts restart_cycle.first
    restart_cycle = restart_cycle.first
    
    complete_cycle = [current_cycle, next_cycle]


    reminder_cycle.each_with_index do |cycle, index|
      complete_cycle << "#{Time.at((Time.now.to_i + (3600 * (index + 2)))).strftime('%D %H:00')} - #{cycle}"
      puts cycle
    end
    
    restart_cycle.each_with_index do |cycle, index|
      complete_cycle << "#{Time.at((Time.now.to_i + (3600 * (index + 2)))).strftime('%D %H:00')} - #{cycle}"
      puts cycle
    end
    
    
    Android::Widget::ArrayAdapter.new(self, Android::R::Layout::Simple_list_item_1, complete_cycle)

  end

end
