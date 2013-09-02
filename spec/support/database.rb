module Etat::SpecHelper
  module Database
    def self.create_database
      SQLite3::Database.new FileUtils.touch(Etat::SpecHelper::Database.db_file).first
      self.connect
      self.create_fake_table
    end

    def self.delete_database
      FileUtils.rm(Etat::SpecHelper::Database.db_file) if File.exists?(Etat::SpecHelper::Database.db_file)
    end

    def self.db_file
      File.expand_path('../../test.db', __FILE__)
    end

    private
    class CreateFakeModel < ActiveRecord::Migration
      def up
        create_table(:fake_models) do |t|
          t.string :state
          t.timestamp
        end
      end
    end

    def self.create_fake_table
      CreateFakeModel.new.up
    end

    def self.connect
      ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: Etat::SpecHelper::Database.db_file)
    end
  end
end