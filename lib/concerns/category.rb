class Category

  def initialize(repo, client)
    @categories = []
    @category_hash = {}
    @start = 0

    open_issues_object = []
    @open_issues = client.issues(repo, :state => "open")
    parse_categories
  end

  def categories
    return @category_hash
  end

  def parse_categories
    @open_issues.each do |issue|
      title = issue.title
      bracket_index = title.index("]")
      if bracket_index
        category = title.slice(0..bracket_index.to_i)
        clean_category = category.delete('[]').downcase
        add_category(clean_category)
      else 
        claen_category = ""
      end
    end
  end

  def add_category(category)
    if !@category_hash[category]
      @categories << category
      @category_hash[category] = 1
    else 
      @category_hash[category] = @category_hash[category] + 1
    end
  end

end