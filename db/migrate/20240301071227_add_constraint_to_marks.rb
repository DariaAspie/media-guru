# frozen_string_literal: true

class AddConstraintToMarks < ActiveRecord::Migration[7.0]
  def up
    execute "ALTER TABLE marks ADD CONSTRAINT digit_check CHECK (digit >= 1 AND digit <= 5)"
  end

  def down
    execute "ALTER TABLE marks DROP CONSTRAINT digit_check"
  end
end
