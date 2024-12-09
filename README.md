# Todo List Feed Feature Specs

---

### Story: Customer requests to see the todo list feed

---

### Narrative #1
```
As an online customer
I want the app to load tasks from the network only on the first launch
So that I can initialize my todo list and cache tasks for future offline use
```
#### Scenarios (Acceptance criteria):

1. **On the first launch with connectivity:**
    ```
    Given this is the user's first app launch
    And the user has connectivity
    When the user requests to see the todo list feed
    Then the app should fetch the latest feed from the network
    And cache the feed for future offline use
    And display the tasks in the app
    ```

2. **On the first launch with no connectivity or network errors:**
    ```    
    Given this is the user's first app launch
    And there are cached tasks available
    When the user requests to see the todo list feed
    Then the app should allow up to two retries for fetching the feed
    And if all retries fail, then the app should load tasks from the cached data
    And If the local cache is empty
    Then the user should see empty tasks list
    And allow the user to add new tasks manually
    ```

3. **On subsequent launches with connectivity or no connectivity:**
    ```
    Given this is not the user's first app launch
    And there are cached tasks available
    When the user requests to see the todo list feed
    Then the app should load tasks from the cached data
    And display them in the app
    ```

4. **On subsequent launches with no cached tasks:**
    ```
    Given this is not the user's first app launch
    And there are no cached tasks
    When the user requests to see the todo list feed
    Then the app should show the empty state screen
    And allow the user to add new tasks
    ```

---

### Narrative #2
```
As an offline customer
I want the app to show an empty todo list screen if no tasks are cached
So that I can add tasks even if I have no connectivity
```

#### Scenarios (Acceptance criteria):

1. **No cached tasks exist:**
    ```
    Given the user has already launched the app before
    And there is no cached tasks available
    And the user has no connectivity
    When the user requests to see the todo list feed
    Then the app should show the empty state screen
    And allow the user to add new tasks
    ```

---

## Model Specs

###TodoItem

| Property      | Type                      |
|---------------|---------------------------|
| 'id'          | 'UUID'                    |
| ‘title’       | 'String'                  |
| 'description' | 'String' Optional         |
| 'completed'   | 'Bool'                    |
| 'createdAt'   | 'Date'                    |
| 'userID'      | 'Int'                     |

## Use Case Flows

### Load Feed From Remote Use Case

#### Data:
- URL
- First app launch check

#### Primary course (happy path) - First App Launch:

1. Detect if this is the user's first app launch.
2. If yes:
    1. Execute **"Load Tasks Feed"** command from Remote with the URL.
    2. System downloads data from the network.
    3. System validates downloaded data.
    4. System caches the feed for future offline use.
    5. System delivers the tasks feed to the user interface.


### Alternate course (sad path) - Network Error on First Launch:
1. Detect if this is the user's first app launch.
2. If yes:
    1. Attempt to execute "Load Tasks Feed" command from Remote.
    2. If the network request fails:
        - Allow the user to retry up to two more times.
    3.If all retries fail:
    - Show the empty state screen.
    - Allow the user to add new tasks manually.
---

### Subsequent Launches:

1. If **not the first launch**:
    1. System checks if cached tasks exist.
2. If cached tasks are available:
    1. Load tasks from the cache.
    2. Deliver the feed to the user interface.
3. If no cached tasks are available:
    1. Show the empty state screen.
    2. Allow the user to add new tasks.

---

### Error Handling:

#### Invalid data response course (sad path):
1. System delivers invalid data error.

#### No connectivity or failed retries:
1. On first launch:
    - Allow up to two retry attempts to fetch data.
    - If retries fail, show the empty state screen and allow manual task creation.
2. On subsequent launches:
    - Load cached data or show the empty state as appropriate.

---

### Cache Feed Use Case

#### Primary course (happy path):
1. Execute **"Save Feed"** with tasks data.
2. System encodes task feed into the CoreData cache.
3. System saves the cache and confirms success.

---


# BDD Specs: Task Management Features (Add, Edit, Delete, Share)

---

### Story: Customer requests to manage tasks in the Todo List

---

### Narrative #1: User Management of Tasks (Add, Edit, Delete, Share)

```
As a customer
I want to add new tasks, edit existing tasks, delete tasks, and share tasks in my Todo list
So that I can efficiently manage my tasks within the app
```

#### Scenarios (Acceptance criteria):

1. **Add a new task:**
   ```
   Given the user is on the todo list feed screen
   When the user taps the "Add Task" button
   Then the app should display a task management screen
   And allow the user to input task details (e.g., title, description)
   When the user submits the task
   Then the app should save the task to the task list
   And display the new task in the list
   ```

2. **Edit an existing task:**
   ```
   Given the user is on the todo list feed screen
   And there is at least one task in the task list
   When the user taps on a task to edit it
   Then the app should display the task management screen
   And allow the user to modify task details (e.g., title, description)
   When the user submits the updated task
   Then the app should save the updated task in the task list
   And reflect the changes in the displayed task list
   ```

3. **Delete a task:**
   ```
   Given the user is on the todo list feed screen
   And there is at least one task in the task list
   When the user swipes or holds on a task to call an action menu to delete the task
   Then the app should confirm the delete action (with an alert or prompt)
   When the user confirms the delete action
   Then the app should remove the task from the task list
   And update the list to reflect the removal of the task
   ```

4. **Share a task:**
   ```
   Given the user is on the todo list feed screen
   And there is at least one task in the task list
   When the user taps on a task to share it
   Then the app should display the "Share" options menu
   And allow the user to share the task via available sharing options (e.g., email, messaging apps, social media)
   When the user selects a sharing option
   Then the app should share the task details through the selected method
   ```

---

### Narrative #2: Offline Management and Task Handling

```
As an offline customer
I want to manage tasks even when I have no connectivity
So that I can add, edit, or delete tasks and still use the app effectively
```

#### Scenarios (Acceptance criteria):

1. **Add a new task while offline:**
   ```
   Given the user is on the todo list feed screen
   And there are no tasks in the list
   And the user has no network connectivity
   When the user taps the "Add Task" button
   Then the app should display the task management screen
   And allow the user to input task details (e.g., title, description)
   When the user submits the task
   Then the app should save the task to the local cache
   And display the new task in the list
   ```

2. **Edit an existing task while offline:**
   ```
   Given the user is on the todo list feed screen
   And there is at least one task in the task list
   And the user has no network connectivity
   When the user taps on a task to edit it
   Then the app should display the task management screen
   And allow the user to modify task details (e.g., title, description)
   When the user submits the updated task
   Then the app should save the updated task to the local cache
   And reflect the changes in the task list
   ```

3. **Delete a task while offline:**
   ```
   Given the user is on the todo list feed screen
   And there is at least one task in the task list
   And the user has no network connectivity
   When the user swipes or taps on a task to delete it
   Then the app should confirm the delete action (with an alert or prompt)
   When the user confirms the delete action
   Then the app should remove the task from the local cache
   And update the task list to reflect the removal
   ```

4. **Share a task while offline:**
   ```
   Given the user is on the todo list feed screen
   And there is at least one task in the task list
   And the user has no network connectivity
   When the user taps on a task to share it
   Then the app should display a message indicating that sharing is unavailable while offline
   And offer the user an option to share the task when connectivity is restored
   ```

---

## New Use Case Flows

### Add Task Use Case

#### Data:
- Task title
- Task description (optional)

#### Primary course (happy path):

1. User taps on the "Add Task" button.
2. The app displays the task creation screen.
3. User enters task details (title, description, etc.).
4. User exists the task management screen and the task is autmatically saved
5. The system saves the new task to the local cache.
6. The system updates the task list with the new task.

---

### Edit Task Use Case

#### Data:
- Task ID
- Updated task details (title, description)

#### Primary course (happy path):

1. User taps on a task in the list to edit.
2. The app displays the task edit screen with pre-filled task details.
3. User modifies the task details (e.g., title, description).
4. User exists the task management screen and the task is autmatically saved
5. The system saves the updated task either to the local cache.
6. The task list is updated to reflect the changes.

---

### Delete Task Use Case

#### Data:
- Task ID

#### Primary course (happy path):

1. User holds on a task and can delete a task in the action menu from the todo list.
2. The app displays a confirmation dialog asking if the user is sure they want to delete the task.
3. User confirms the deletion.
4. The system removes the task from the local cache and/or remote server (if online).
5. The task is removed from the task list and the UI is updated.

---

### Share Task Use Case

#### Data:
- Task details (title, description)

#### Primary course (happy path):

1. User taps on a task in the list to share it.
2. The app displays the sharing options menu.
3. User selects a sharing option (e.g., email, messaging app, social media).
4. The app shares the task details through the selected method.
5. User receives feedback (e.g., "Task shared successfully").

---

## Error Handling:

#### Invalid Data:

1. If the task data is invalid (e.g., missing required fields):
   - The app should display an error message prompting the user to fix the input.

---



