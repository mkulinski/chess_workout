$(function() {
  initPage();
});
$(window).bind('page:change', function() {
  initPage();
});

function initPage() {
  "use strict";

  var colors = ["white_", "dark_"]

  var pieces = [
    "king",
    "queen",
    "bishop1",
    "bishop2",
    "knight1",
    "knight2",
    "rook1",
    "rook2",
    "pawn1",
    "pawn2",
    "pawn3",
    "pawn4",
    "pawn5",
    "pawn6",
    "pawn7",
    "pawn8"
  ];

  var pos = {
    white_king: "85",
    white_queen: "84",
    white_bishop1: "83",
    white_bishop2: "86",
    white_knight1: "82",
    white_knight2: "87",
    white_rook1: "81",
    white_rook2: "88",
    white_pawn1: "71",
    white_pawn2: "72",
    white_pawn3: "73",
    white_pawn4: "74",
    white_pawn5: "75",
    white_pawn6: "76",
    white_pawn7: "77",
    white_pawn8: "78",
    dark_king: "15",
    dark_queen: "14",
    dark_bishop1: "13",
    dark_bishop2: "16",
    dark_knight1: "12",
    dark_knight2: "17",
    dark_rook1: "11",
    dark_rook2: "18",
    dark_pawn1: "21",
    dark_pawn2: "22",
    dark_pawn3: "23",
    dark_pawn4: "24",
    dark_pawn5: "25",
    dark_pawn6: "26",
    dark_pawn7: "27",
    dark_pawn8: "28"
  };

  var top_z = 100;
  var start_sq = 99;

  for (let color of colors) {
    for (let piece of pieces) {
      $("#" + color + piece).appendTo($("#" + pos[color + piece])).draggable({
        cursor: "pointer",
        containment: ".board",
        snap: ".board td",
        snapTolerance: 20,
        revert: "invalid",
        start: function() {
          start_sq = this.closest("td").id;
        }
      }).on("mousedown", function() {
        this.style.zIndex = ++top_z;
      });
    }
  }

  $(".board td").droppable({
    accept: ".piece",
    tolerance: "fit",
    drop: handleDrop
  });

  function handleDrop(event, ui) {
    $(".board td").removeClass("moved_sq");
    if (this.id != start_sq) {
      if ($(this).find(".piece").hasClass("white_piece")) {
        $(this).find(".piece").appendTo("#white_captured");
      } else {
        $(this).find(".piece").appendTo("#dark_captured");
      }
      $(this).empty();
    } else {
      return;
    }

    var targetDIV = document.getElementById('targetDIV');
    var dropTarget = $(this);

    ui.draggable.draggable("option", "revert", false);

    var oldPosition = ui.draggable.offset();

    $(ui.draggable).appendTo(this);

    var newPosition = ui.draggable.offset();

    var leftOffset = null;
    var topOffset = null;

    if (oldPosition.left > newPosition.left) {
      leftOffset = (oldPosition.left - newPosition.left);
    } else {
      leftOffset = -(newPosition.left - oldPosition.left);
    }

    if (oldPosition.top > newPosition.top) {
      topOffset = (oldPosition.top - newPosition.top);
    } else {
      topOffset = -(newPosition.top - oldPosition.top);
    }

    ui.draggable.animate({
      left: '+=' + leftOffset,
      top: '+=' + topOffset,
    }, 0)

    ui.draggable.draggable("option", "revert", true);

    $("#" + start_sq).addClass("moved_sq");
    $(this).addClass("moved_sq");

    $("#moves").prepend("<li>" + ui.draggable.attr("id") + ": " + start_sq + " --> " + this.id + "</li>");
  };

  $("#reverse_view").on("click", function() {
    // Reverse board columns
    $("tr").each(function(elem, index) {
      var arr_cols = $.makeArray($("td", this).detach());
      arr_cols.reverse();
      $(this).append(arr_cols);
    });
    // Reverse board rows
    $("tbody").each(function(elem, index) {
      var arr_rows = $.makeArray($("tr", this).detach());
      arr_rows.reverse();
      $(this).append(arr_rows);
    });
  });
}
