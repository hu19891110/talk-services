// Generated by CoffeeScript 1.10.0
(function() {
  var _receiveWebhook, util;

  util = require('../util');

  _receiveWebhook = function(arg) {
    var body, err, error, message, payload;
    body = arg.body;
    payload = body != null ? body.payload : void 0;
    try {
      if (toString.call(payload) === '[object String]') {
        payload = JSON.parse(payload);
      }
      if (toString.call(payload) !== '[object Object]') {
        return false;
      }
    } catch (error) {
      err = error;
      return false;
    }
    if (!payload.title) {
      throw new Error('Params missing');
    }
    message = {
      attachments: [
        {
          category: 'quote',
          data: {
            title: payload.title,
            text: payload.message,
            redirectUrl: payload.build_url
          }
        }
      ]
    };
    return message;
  };

  module.exports = function() {
    this.title = 'Magnum CI';
    this.template = 'webhook';
    this.summary = util.i18n({
      zh: '可用于私有项目的持续集成平台',
      en: 'Hosted Continuous Integration Platform for Private Repositories'
    });
    this.description = util.i18n({
      zh: '可用于私有项目的持续集成平台',
      en: 'Hosted Continuous Integration Platform for Private Repositories'
    });
    this.iconUrl = util["static"]('images/icons/magnumci@2x.png');
    this._fields.push({
      key: 'webhookUrl',
      type: 'text',
      readonly: true,
      description: util.i18n({
        zh: '复制 web hook 地址到你的 Magnum CI 中使用。',
        en: 'Copy this web hook to your Magnum CI account to use it.'
      })
    });
    return this.registerEvent('service.webhook', _receiveWebhook);
  };

}).call(this);