class Milestone

  def initialize(repo, milestone, client)
    @hash_values = []
    @array_of_issue_labels = []
    @low_priority = []

    @high_points = 0
    @normal_points = 0
    @low_points = 0 

    client.auto_paginate = true
    @issues = client.list_issues(repo, milestone: milestone)
    self.extract_labels
    @hash_values.flatten!
    self.create_stats
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

  def create_stats

    @array_of_issue_labels.each do |labels|
      
      labels.flatten!
      if labels.include?("priority: high") 
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @high_points += size.first.split(":").last.to_f
        end
      end

      if labels.include?("priority: normal") 
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @normal_points += size.first.split(":").last.to_f
        end
      end

      if labels.include?("priority: low") 
        size = labels.select { |l| l.split(":").first == "size"}
        if !size.empty?
          @low_points += size.first.split(":").last.to_f
        end
      end

    end
    
  end

end