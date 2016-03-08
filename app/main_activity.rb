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
    current_cycle_index = (current_hour) % 20 + offset
    next_cycle_index = (current_hour) % 20 + offset + 1
    current_cycle = "Current Cycle | until #{Time.at((Time.now.to_i)).strftime('%H:59:59')} - #{@complete_list[current_cycle_index]}"
    next_cycle =  "Next Cycle | starting #{Time.at((Time.now.to_i + 3600)).strftime('%H:00')} - #{@complete_list[next_cycle_index]}"
    reminder_cycle = []
    #puts next_cycle_index # used to validate the loopback after I reach the end of the cycle list 
    if next_cycle_index < 20
      reminder_cycle = reminder_cycle << @complete_list[next_cycle_index + 1 .. @complete_list.length + 1 ]
      reminder_cycle = reminder_cycle << @complete_list[0.. current_cycle_index - 1]
    else
      reminder_cycle = reminder_cycle << @complete_list
    end
    
    complete_cycle = [current_cycle, next_cycle]

    reminder_cycle.each_with_index do |cycle, index|
      complete_cycle << "#{Time.at((Time.now.to_i + (3600 * (index + 2)))).strftime('%D %H:00')} - #{cycle}"
    end

    Android::Widget::ArrayAdapter.new(self, Android::R::Layout::Simple_list_item_1, complete_cycle)

  end

end
