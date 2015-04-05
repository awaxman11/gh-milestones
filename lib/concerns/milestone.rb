class Milestone

  def initialize(repo, milestone, client)
    @hash_values = []
    @array_of_issue_labels = []
    @low_priority = []

    @high_points = 0
    @normal_points = 0
    @low_points = 0 
    @no_priority_points = 0 
    
    @high_no_points = 0
    @normal_no_points = 0
    @low_no_points = 0 
    @no_priority_no_points = 0  

    @no_priority_count = 0

    @stats = {
      :high => {},
      :normal => {},
      :low => {},
      :no_priority => {},
      :total => {}
    }

    client.auto_paginate = true
    @milestone = client.milestone(repo, milestone)
    @issues = client.list_issues(repo, milestone: milestone)
    self.extract_labels
    @hash_values.flatten!
    self.get_points
    self.assign_points
    self.assign_count
  end

  def issues
    @issues
  end

  def milestone
    @milestone
  end

  def stats
    @stats
  end

  def is_no_priority?
    return @no_priority_count == 0
  end

  def get_stats
    pretty_stats = []
    pretty_stats.push("High priority issues: " + @hash_values.select { |l| l == "priority: high" }.count.to_s + " (" + @high_points.to_s + " pts)")
    pretty_stats.push("Normal priority issues: " + @hash_values.select { |l| l == "priority: normal" }.count.to_s + " (" + @normal_points.to_s + " pts)")
    pretty_stats.push("Low priority issues: " + @hash_values.select { |l| l == "priority: low" }.count.to_s + " (" + @low_points.to_s + " pts)")
    pretty_stats.push("Total points: " + @hash_values.select{|l| l.split(":").first == "size"}.map{|s| s.split(":").last.to_f }.inject(:+).to_s)
    return pretty_stats
  end

  def extract_labels
    issues.each do |issue|
      
      issue[:labels].flat_map do |labels|
        @hash_values << labels.to_hash.values
      end

      @array_of_issue_labels << issue[:labels].map {|l| l.to_hash.values.to_a }

    end
  end

  def get_points

    @array_of_issue_labels.each do |labels|
      
      labels.flatten!
      if labels.include?("priority: high") 
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @high_points += size.first.split(":").last.to_f
        else
          @high_no_points += 1
        end

      elsif labels.include?("priority: normal") 
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @normal_points += size.first.split(":").last.to_f
        else
          @normal_no_points += 1
        end

      elsif labels.include?("priority: low") 
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @low_points += size.first.split(":").last.to_f
        else
          @low_no_points += 1
        end
      
      else 
        @no_priority_count += 1
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @no_priority_points += size.first.split(":").last.to_f
        else
          @no_priority_no_points += 1
        end
      end



    end
    
  end

  def assign_points
    @stats[:high][:points] = @high_points
    @stats[:normal][:points] = @normal_points
    @stats[:low][:points] = @low_points
    @stats[:no_priority][:points] = @no_priority_points
    @stats[:total][:points] = @high_points + @normal_points + @low_points + @no_priority_points

    @stats[:high][:no_points] = @high_no_points
    @stats[:normal][:no_points] = @normal_no_points
    @stats[:low][:no_points] = @low_no_points
    @stats[:no_priority][:no_points] = @no_priority_no_points
    @stats[:total][:no_points] = @high_no_points + @normal_no_points + @low_no_points + @no_priority_no_points

  end

  def assign_count
    @stats[:high][:count] = @hash_values.select { |l| l == "priority: high" }.count
    @stats[:normal][:count] = @hash_values.select { |l| l == "priority: normal" }.count
    @stats[:low][:count] = @hash_values.select { |l| l == "priority: low" }.count
    @stats[:no_priority][:count] = @no_priority_count
    @stats[:total][:count] = issues.count
  end
  

end