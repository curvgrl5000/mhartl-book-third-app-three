module ApplicationHelper
  
  # Returns the full title on a per-page basis.            # Documentation comment
  def full_title(page_title)                               # Method definition with 1 argument
    base_title = "RonR Sample App"                         # Variable assignment
      if page_title.empty?                                 # Boolean test
       return base_title                                    # Implicit return of the var 'base_title'  
      else
        "#{base_title} | #{page_title}"                    # String interpolation
      end
   end
end



