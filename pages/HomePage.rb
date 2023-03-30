class HomePage < BasePage
    def search_for(query)
        fill_in('#search-field', with: query)
        click('#search-button')
    end
end
  