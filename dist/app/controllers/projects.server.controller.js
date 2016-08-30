var Project, getErrorMessages;

Project = require('mongoose').model('Project');

getErrorMessages = function(err) {
  var errors, k, v, _ref;
  if (err.errors) {
    errors = [];
    _ref = err.errors;
    for (k in _ref) {
      v = _ref[k];
      if (v.message) {
        errors.push(v.message);
      }
    }
    return errors;
  } else if (err.message) {
    return [err.message];
  } else {
    return ['Unknow server error'];
  }
};

exports.create = function(req, res, next) {
  var project;
  console.log(req.body);
  project = new Project(req.body);
  project.creator = req.user;
  return project.save(function(err) {
    if (err) {
      return res.status(400).send({
        errorMessages: getErrorMessages(err)
      });
    } else {
      return res.json(project);
    }
  });
};

exports.list = function(req, res) {
  return Project.find({
    creator: req.user
  }).exec(function(err, projects) {
    if (err) {
      return res.status(400).send({
        errorMessages: getErrorMessages(err)
      });
    } else {
      return res.json(projects);
    }
  });
};

exports.projectByID = function(req, res, next, id) {
  return Project.findById(id).populate('creator', 'firstName lastName userName').exec(function(err, project) {
    if (err) {
      return next(err);
    }
    if (!project) {
      return next(new Error('Failed to load the project'));
    }
    req.project = project;
    return next();
  });
};

exports.update = function(req, res) {
  var project;
  project = req.project;
  project.name = req.body.name;
  project.tasks = req.body.tasks;
  return project.save(function(err) {
    if (err) {
      return res.status(400).send({
        errorMessages: getErrorMessages(err)
      });
    } else {
      return res.json(project);
    }
  });
};

exports["delete"] = function(req, res) {
  var project;
  project = req.project;
  return project.remove(function(err) {
    if (err) {
      return res.status(400).send({
        errorMessages: getErrorMessages(err)
      });
    } else {
      return res.json(project);
    }
  });
};

exports.hasAuthorization = function(req, res, next) {
  console.log(req.user);
  console.log(req.project);
  if (!req.user._id.equals(req.project.creator._id)) {
    return res.status(403).send({
      message: 'User is not authorized'
    });
  }
  return next();
};
