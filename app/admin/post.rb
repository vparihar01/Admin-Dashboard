ActiveAdmin.register Post do

  form do |f|
    f.inputs "Post Details" do
      f.input :title
      f.input :content
      f.input :created_at
    end
    f.buttons
  end

  create_or_edit = Proc.new {
    @post            = Post.find_or_create_by_id(params[:id])
    @post.attributes = params[:post]
    if @post.save
      redirect_to :action => :show, :id => @post.id
    else
      render active_admin_template((@post.new_record? ? 'new' : 'edit') + '.html.erb')
    end
  }
  member_action :create, :method => :post, &create_or_edit
  member_action :update, :method => :put, &create_or_edit

end