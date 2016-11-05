require 'mechanize'
class Overview

  def self.get_links(client)
    
    @stats = {
      :rate_limit => {}
    }

    login

    add_link("no_priority", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen+-label%3A%22priority%3A+high%22+-label%3A%22priority%3A+normal%22+-label%3A%22priority%3A+low%22++-label%3A%22type%3A+postmortem%22++-label%3A%22type%3A+project%22++-label%3A%22team%3A+mapping%22++-label%3A%22Good+for+technical+debt+day%22++-label%3A%22team%3A+data%22+-label%3A%22team%3A+ops%22++created%3A%3E2015-01-01+-label%3A%22type%3A+good+for+technical+debt+day%22+repo%3Aseatgeek%2Ftixcast+", "need priority")

    since_mon_needs_pts_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aissue+is%3Aopen++-label%3A%22size%3A+0.5%22+-label%3A%22size%3A+1%22+-label%3A%22size%3A+2%22++-label%3A%22size%3A+3%22++-label%3A%22size%3A+4%22++-label%3A%22size%3A+5%22++-label%3A%22size%3A+6%22++-label%3A%22size%3A+7%22++-label%3A%22size%3A+8%22++-label%3A%22size%3A+10%22++-label%3Aproject+-label%3Apostmortem++-label%3Aspec+-label%3A%22type%3A+good+for+technical+debt+day%22+' + CGI.escape(created(">",monday_morning))
    add_link(:since_mon_needs_pts, since_mon_needs_pts_link, "need pts this week")

    since_mon_link = "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen" + CGI.escape(created(">",monday_morning))
    add_link(:since_mon, since_mon_link, "created this week")

    add_link("high_priority", "https://github.com/seatgeek/tixcast/labels/priority%3A%20high", "high priority issues")

    high_priority_30_days_ago_link = 'https://github.com/seatgeek/tixcast/issues?utf8=✓&q=is%3Aopen+label%3A"priority%3A+high"' + CGI.escape(created("<",days_ago(30)))
    add_link(:hp_30_days, high_priority_30_days_ago_link, "hp > 30 days ago")

    normal_priority_365_days_ago_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen+label%3A%22priority%3A+normal%22+sort%3Aupdated-asc+' + CGI.escape(created("<",days_ago(365)))
    add_link(:np_365_days, normal_priority_365_days_ago_link, "np > 365 days ago")

    @stats[:rate_limit][:link] = "https://developer.github.com/v3/rate_limit/"
    @stats[:rate_limit][:count] = client.rate_limit.remaining
    return @stats
  end

  def self.get_triage_stats_all_issues_links(client)
    
    @stats = {
      :rate_limit => {}
    }

    login

    add_link("total", "https://github.com/seatgeek/tixcast/labels/status%3A%20needs%20triage", "total")

    add_link("no_team", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=label%3A%22status%3A%20needs%20triage%22%20is%3Aopen%20%20-label%3A%22team%3A%203%22%20-label%3A%22team%3A%20platform%22%20-label%3A%22team%3A%20discovery%22%20-label%3A%22team%3A%20inventory%22%20-label%3A%22team%3A%20other%22%20-label%3A%22team%3A%20ops%22%20-label%3A%22team%3A%20maps%22%20-label%3A%22team%3A%20open%22%20-label%3A%22team%3A%20data%22", "needs team")

    add_link("team_other", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20other%22%20", "team other")

    add_link("team_3", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%203%22%20", "seatgeek.com")

    add_link("team_data", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20data%22%20", "data science")

    add_link("team_discovery", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20discovery%22%20", "discovery")

    add_link("team_inventory", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20inventory%22%20", "inventory")

    add_link("team_maps", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20maps%22%20", "maps")

    add_link("team_open", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20open%22%20", "open")

    add_link("team_ops", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20ops%22%20", "ops")

    add_link("team_platform", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20platform%22%20", "platform")

    @stats[:rate_limit][:link] = "https://developer.github.com/v3/rate_limit/"
    @stats[:rate_limit][:count] = client.rate_limit.remaining
    return @stats
  end

  def self.get_triage_stats_stale_issues_links(client)
    
    @stats = {
      :rate_limit => {}
    }

    login

    # Define number of days without being updated to consider an issue "stale"
    stale_day_count = 7

    total_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=✓&q=is%3Aopen+label%3A"status%3A%20needs%20triage"' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:total, total_stale_link, "total stale")

    no_team_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=label%3A%22status%3A%20needs%20triage%22%20is%3Aopen%20%20-label%3A%22team%3A%203%22%20-label%3A%22team%3A%20platform%22%20-label%3A%22team%3A%20discovery%22%20-label%3A%22team%3A%20inventory%22%20-label%3A%22team%3A%20other%22%20-label%3A%22team%3A%20ops%22%20-label%3A%22team%3A%20maps%22%20-label%3A%22team%3A%20open%22%20-label%3A%22team%3A%20data%22' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:no_team, no_team_stale_link, "needs team")

    team_other_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20other%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_other, team_other_stale_link, "team other")

    team_3_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%203%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_3, team_3_stale_link, "seatgeek.com")

    team_data_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20data%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_data, team_data_stale_link, "data science") 

    team_discovery_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20discovery%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_discovery, team_discovery_stale_link, "discovery")    

    team_inventory_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20inventory%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_inventory, team_inventory_stale_link, "inventory")    

    team_maps_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20maps%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_maps, team_maps_stale_link, "maps")    

    team_open_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20open%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_open, team_open_stale_link, "open")  

    team_ops_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20ops%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_ops, team_ops_stale_link, "ops")  

    team_platform_stale_link = 'https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen%20label%3A%22status%3A%20needs%20triage%22%20label%3A%22team%3A%20platform%22%20' + CGI.escape(updated("<",days_ago(stale_day_count)))
    add_link(:team_platform, team_platform_stale_link, "platform")            

    @stats[:rate_limit][:link] = "https://developer.github.com/v3/rate_limit/"
    @stats[:rate_limit][:count] = client.rate_limit.remaining
    return @stats
  end

  def self.parse_link(link)
    t = @a.get(link)
    return t.parser.at('.table-list-header-toggle').search('a')[0].children.last.text.strip.split(' ').first.delete(',').to_i
  end

  def self.login
    @a = Mechanize.new
    @b = @a.get('https://github.com/login')
    @a.get('https://github.com/login') do |page|
      # Click the login link
      @page = page
      # Submit the login form
      @my_page = page.form_with(:action => '/session') do |f|
        puts f
        f.login     = ENV['GITHUB_LOGIN']
        f.password  = ENV['GITHUB_PASS']
      end.click_button

    end
  end

  def self.created(type, time)
    return " created" + ":" + type + time.to_s  
  end

  def self.updated(type, time)
    return " updated" + ":" + type + time.to_s  
  end

  def self.add_link(name, link, label)
    symbol = name.to_sym
    @stats[symbol] = {}
    @stats[symbol][:link] = link
    @stats[symbol][:count] = parse_link(link)
    @stats[symbol][:label] = label
  end

  def self.days_ago(days)
    now = DateTime.now
    return now - days   
  end 

  def self.monday_morning
    now = DateTime.now
    y = now.year
    m = now.month
    d = now.day
    today_at_9 = DateTime.new(y, m, d, 9, 0)
    return today_at_9 - (today_at_9 - 1).wday
  end

end