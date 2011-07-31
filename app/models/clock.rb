class Clock < ActiveRecord::Base
  belongs_to :task
  belongs_to :user

  def in?
    in_out == 0 || in_out == nil ? true : false
  end
  
  def status
    if in?
      'In'
    else
      'Out'
    end
  end

  def time(num)
    @clock = Clock.find(:all, :conditions => ["created_at >= ? AND created_at <= ? and user_id = ? and in_out = ?",created_at.beginning_of_day, created_at.end_of_day,user_id,num])
    #@clock = Clock.where('user_id = ? and in_out = ? and created_at = ?',user_id, num, created_at)
    
    if @clock != nil
      @clock.first.created_at
    end
  end
 
end
