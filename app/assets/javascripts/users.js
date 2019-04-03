$(document).on('turbolinks:load', function() {

  var userSearch = $('#user-search');
  var userList = $('#user-list');
  var projectMember = $('#project-member');

  function appendUser(user) {
    var html = `
      <li class="border rounded mt-1">
        <div class="row">
          <div class="col my-auto ml-3">
            ${user.name}
          </div>
          <div class="col">
            <div class="btn btn-outline-primary float-right" id="user-append" data-user-id="${user.id}" data-user-name="${user.name}">
              追加
            </div>
          </div>
        </div>
      </li>
    `
    userList.append(html);
  }

  function appendNoUser(text) {
    var html = `
      <li class="border rounded mt-1">
        <div class="row">
          <div class="col ml-3" style="line-height: 38px;">
            ${text}
          </div>
        </div>
      </li>
    `
    userList.append(html);
  }

  function appendMember(userId, userName) {
    var html =`
      <li class="border rounded mt-1">
        <input name="project[user_ids][]" type="hidden" value="${userId}">
        <div class="row">
          <div class="col my-auto ml-3">
            ${userName}
          </div>
          <div class="col">
            <div class="btn btn-outline-danger float-right" id="user-remove">
              除外
            </div>
          </div>
        </div>
      </li>
    `
    projectMember.append(html);
  }

  userSearch.on('keyup', function() {
    var input = userSearch.val()
    if ($('.edit_project').length === 1) {
      var projectId = $('.edit_project').attr('action').match(/\d+/)[0]
    }

    $.ajax({
      type:     'GET',
      url:      '/users',
      data:     { keyword: input, project_id: projectId},
      dataType: 'json'
    })
    .done(function(users) {
      userList.empty();
      if (users.length) {
        users.forEach(function(user) {
          appendUser(user);
        });
      } else {
        appendNoUser('No User')
      }
    })
    .fail(function() {
      alert('通信に失敗しました')
    });
  });

  userList.on('click', '#user-append', function() {
    $('#project-form')[0].reset();
    userList.empty();
    var userId = $(this).attr('data-user-id');
    var userName = $(this).attr('data-user-name');
    appendMember(userId, userName);
  });

  projectMember.on('click', '#user-remove', function() {
    $(this).parent().parent().parent().remove();
  });
});
