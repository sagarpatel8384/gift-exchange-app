class Parser
  def self.build_html(data)
    "<table class='table table-striped'><thead><tr><th>Gift Giver</th><th>Gift Receiver</th></tr></thead><tbody>" + self.build_table_data(data) + "</tbody></table>"
  end

  def self.build_table_data(data)
    data.inject("") do |accumulator, (giver, receiver)|
      accumulator + "<tr><td>" + giver + "</td><td>" + receiver + "</td></tr>"
    end
  end
end
