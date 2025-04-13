class AddResumeColumnOnJobApplication < ActiveRecord::Migration[8.0]
  def change
    add_column :job_applications, :resume, :string
    add_column :job_applications, :cover_letter, :text
    change_column_default :job_applications, :status, from: nil, to: "Submitted"
  end
end
