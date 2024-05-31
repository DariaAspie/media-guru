# frozen_string_literal: true

# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggerMarksInsert < ActiveRecord::Migration[7.0]
  def up
    create_trigger("marks_after_insert_row_tr", generated: true, compatibility: 1).on("marks").after(:insert) do
      <<-SQL_ACTIONS
        UPDATE videos SET rating = (
          select avg(marks.digit)
          from marks
              where marks.video_id = NEW.video_id)
          WHERE videos.id = NEW.video_id;
      SQL_ACTIONS
    end

    create_trigger("marks_after_delete_row_tr", generated: true, compatibility: 1).on("marks").after(:delete) do
      <<-SQL_ACTIONS
        UPDATE videos SET rating = (
          select avg(marks.digit)
          from marks
              where marks.video_id = OLD.video_id)
          WHERE videos.id = OLD.video_id;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("marks_after_insert_row_tr", "marks", generated: true)
    drop_trigger("marks_after_delete_row_tr", "marks", generated: true)
  end
end
