mongoose = require 'mongoose'
{Schema} = mongoose
crypto = require 'crypto'

IntegrationSchema = new Schema
  creator: type: Schema.Types.ObjectId
  team: type: Schema.Types.ObjectId
  room: type: Schema.Types.ObjectId
  serviceName:  String
  category: type: String # Integration category: weibo/github
  hashId: type: String, default: -> crypto.createHash('sha1').update("#{Date.now()}").digest('hex')
  # For authorized integrations
  token: String
  refreshToken: String
  showname: type: String
  openId: String
  notifications: Object
  # Options
  title: type: String
  iconUrl: String
  # Rss
  url: String
  description: type: String
  # Github
  repos: Array
  # Data saved by system
  data: Object
  errorInfo: String
  createdAt: type: Date, default: Date.now
  updatedAt: type: Date, default: Date.now

IntegrationSchema.virtual '_creatorId'
  .get -> @creator?._id or @creator
  .set (_id) -> @creator = _id

IntegrationSchema.virtual '_roomId'
  .get -> @room?._id or @room
  .set (_id) -> @room = _id

IntegrationSchema.virtual '_teamId'
  .get -> @team?._id or @team
  .set (_id) -> @team = _id

IntegrationSchema.methods.save = (callback = ->) -> callback null, this

module.exports = IntegrationSchema
