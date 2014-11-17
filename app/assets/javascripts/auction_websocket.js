var AuctionSocket = function(user_id, auction_id, form) {
  this.user_id = user_id;
  this.auction_id = auction_id;
  this.form = $(form);

  this.socket = new WebSocket(App.websocket_url + "auctions/" + this.auction_id);

  this.initBinds();
};

AuctionSocket.prototype.initBinds = function() {
  var _this = this;

  this.form.submit(function(e) {
    e.preventDefault();
    _this.sendBid($("#bid_value").val());
  });

  this.socket.onmessage = function(e) {
    // bidok
    // underbid
    // outbid 123
    // won
    // lost
    var tokens = e.data.split(" ");

    switch(tokens[0]) {
      case "bidok":
        _this.bid(tokens[1]);
        break;
      case "underbid":
        _this.underbid(tokens[1]);
        break;
      case "outbid":
        _this.outbid(tokens[1]);
        break;
      case "won":
        _this.won();
        break;
      case "lost":
        _this.lost();
        break;
    }
    console.log(e);
  };
};

AuctionSocket.prototype.sendBid = function(value) {
  this.value = value;
  var template = "bid {{auction_id}} {{user_id}} {{value}}";
  this.socket.send(Mustache.render(template, {
    user_id: this.user_id,
    auction_id: this.auction_id,
    value: value
  }));
};

AuctionSocket.prototype.bid = function() {
  this.form.find(".message strong").html(
    "Your bid: " + this.value
  );
};

AuctionSocket.prototype.underbid = function(value) {
  this.form.find(".message strong").html(
    "Your bid is under " + value + "."
  );
};

AuctionSocket.prototype.outbid = function(value) {
  this.form.find(".message strong").html(
    "You were outbid. It is now " + value + "."
  );
};

AuctionSocket.prototype.won = function() {
  this.form.find(".message strong").html(
    "You won! " + this.value
  );
};

AuctionSocket.prototype.lost = function() {
  this.form.find(".message strong").html("You lost the auction.");
};
