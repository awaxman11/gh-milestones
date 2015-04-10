require 'mechanize'
class Overview

  def self.get_links(client)
    
    @stats = {
      :rate_limit => {}
    }

    login

    add_link("no_priority", "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen+-label%3A%22priority%3A+high%22+-label%3A%22priority%3A+normal%22+-label%3A%22priority%3A+low%22++-label%3A%22Postmortem%22++-label%3A%22Project%22++-label%3A%22team%3A+mapping%22++-label%3A%22Good+for+technical+debt+day%22++-label%3A%22team%3A+data%22+-label%3A%22team%3A+ops%22++created%3A%3E2015-01-01+repo%3Aseatgeek%2Ftixcast")
    mon_morning_link = "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen+" + CGI.escape(updated(">",monday_morning))
    add_link(:since_mon, mon_morning_link)
    # no_priority_count = client.search_issues('is:open -label:"priority: high" -label:"priority: normal" -label:"priority: low"  -label:"Postmortem"  -label:"Project"  -label:"team: mapping"  -label:"Good for technical debt day"  -label:"team: data" -label:"team: ops"  created:>2015-01-01 repo:seatgeek/tixcast')[:total_count]
    # @stats[:no_priority][:link] = "https://github.com/seatgeek/tixcast/issues?utf8=%E2%9C%93&q=is%3Aopen+-label%3A%22priority%3A+high%22+-label%3A%22priority%3A+normal%22+-label%3A%22priority%3A+low%22++-label%3A%22Postmortem%22++-label%3A%22Project%22++-label%3A%22team%3A+mapping%22++-label%3A%22Good+for+technical+debt+day%22++-label%3A%22team%3A+data%22+-label%3A%22team%3A+ops%22++created%3A%3E2015-01-01+repo%3Aseatgeek%2Ftixcast"
    # @stats[:no_priority][:count] = no_priority_count
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

  def self.updated(type, time)
    return "created" + ":" + type + time.to_s  
  end

  def self.add_link(name, link)
    symbol = name.to_sym
    @stats[symbol] = {}
    @stats[symbol][:link] = link
    @stats[symbol][:count] = parse_link(link)
  end 

  def self.monday_morning
    now = DateTime.now
    y = now.year
    m = now.month
    d = now.day
    today_at_9 = DateTime.new(y, m, d, 9)
    return now - now.wday + 1
  end

end