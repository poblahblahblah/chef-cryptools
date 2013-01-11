# Using the AttrLoader module from the base cookbook to automatically
# load attributes for us. This is a "feature" we implemented and not
# a built-in feature from Chef
AttrLoader.load_me(File.dirname(__FILE__), node)
