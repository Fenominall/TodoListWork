# Specify the workspace where both projects are combined
workspace 'TodoListWorkApp'

# macOS and iOS framework project
project 'TodoListWork/TodoListWork.xcodeproj'

# Target for the iOS framework within the macOS project
target 'TodoListWorkiOS' do
  platform :ios, '14.0' # Adjust this if necessary
  use_frameworks!

  # Pods for the iOS target in the macOS project
  pod 'SnapKit', '~> 5.7.0'
end