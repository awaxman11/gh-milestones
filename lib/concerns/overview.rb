class Overview

  def self.get_links(client)
    
    stats = {
      no_priority: {},
      issues_this_week: {}
    }

    no_priority_count = client.search_issues('is:open -label:"priority: high" -label:"priority: normal" -label:"priority: low"  -label:"Postmortem"  -label:"Project"  -label:"team: mapping"  -label:"Good for technical debt day"  -label:"team: data" -label:"team: ops"  created:>2015-01-01 repo:seatgeek/tixcast')[:total_count]
    stats[:no_priority][:link] = "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen+-label%3A%22priority%3A+high%22+-label%3A%22priority%3A+normal%22+-label%3A%22priority%3A+low%22++-label%3A%22Postmortem%22++-label%3A%22Project%22++-label%3A%22team%3A+mapping%22++-label%3A%22Good+for+technical+debt+day%22++-label%3A%22team%3A+data%22+-label%3A%22team%3A+ops%22++created%3A%3E2015-01-01+repo%3Aseatgeek%2Ftixcast"
    stats[:no_priority][:count] = no_priority_count
    stats[:issues_this_week][:link] = "https://github.com/seatgeek/tixcast/"
    stats[:issues_this_week][:count] = 12
    return stats
  end

end