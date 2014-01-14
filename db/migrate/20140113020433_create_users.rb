class CreateUsers < ActiveRecord::Migration
  def change                      # 'change' is the method that determines the change(s) to be made to a database
    create_table :users do |t|    # 'create_table' is a Rails method that creates a table in the database for storing users,
                                  #  'create_table' works with a code block ":users do |t| ... end ", where |t| is the singular block variable.
                                  #  (t stands for table), the 't' object that gets used to create the name and email columns in the database
      
      t.string :name              #  't.string :name' is a column in the table
      t.string :email             #  't.string :email' is a column in the table

      t.timestamps                #  't.timestamp' is a special command that creates two columns: created_at and updated_at
                                  #   which automatically timestapt when a given user is created and updated. 
    end
  end
end

# On line 3, we see the symbol ':users' is being used to create a Table of Users, it's plural
# Yet when you go to the folder 'models', and open the file 'user.rb', you see that the class is singular, 'User'
# This represents a convention: a model represents a single user, whereas a database table consists of many users, hence the naming convention

# REMEMBER, the only thing we are not accounting for is the id column, because that's built in Rails automatically.