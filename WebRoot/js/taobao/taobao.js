                    // 颜色
                    function changeColorProp(that) {

                        var $this = $(that);

                        // 将sku组合为tr的class

                        // 提取状态
                        var color_check_status = that.checked;

                        // 提取
                        var color_class_name = $this.attr("class");

                        // 提取属性字穿
                        var color_id = $this.val();
                        
                        // 获取销售属性的个数
                        var len = $(".li_sale_prop").length;


                        if (color_check_status) {
                            var color_name = $this.next().children("input").first().val();
                            var list = new Array();
                            var skuids = new Array();
                            $(".saleProps").each(function(i, n) {
                                var sale_check = $(n);
                                if (n.checked) {
                                    var td_val = sale_check.next().children("input").first().val();
                                    var sale_id = sale_check.val();
                                    var sku_id = color_id + ";" + sale_id;
                                    skuids.push(sku_id);
                                    if (td_val != undefined) {
                                        list.push(td_val);
                                    }
                                }
                            });
                            // console.log(skuids);
                            // console.log(list);

                            if(len === 1){
                                list.push("");
                                skuids.push(color_id);
                            }
                            // 组合表格
                            var tr_html = "";
                            for (var i = 0; i < list.length; i++) {
                                var index = i + ($("#sku_table tr").length - 1);
                                if (i == 0) {
                                    tr_html += "<tr class='" + skuids[i] + "' data='" + skuids[i] + "'>" +
                                        "<td rowspan=" + (list.length) + ">" + color_name + "</td>" +
                                        "<td>" + list[i] + "</td>" +
                                        "<td>" +
                                        "<input type='hidden' class='input_class' name='skus[" + index + "].propIdStr' value='" + skuids[i] + "' />" +
                                        "<input type='text' class='input_class' name='skus[" + index + "].quality' />" +
                                        "</td>" +
                                        "<td><input  type='text' class='input_class' name='skus[" + index + "].price'  /></td>" +
                                        "</tr>";
                                } else {
                                    tr_html += "<tr class='" + skuids[i] + "'>" +
                                        "<td>" + list[i] + "</td>" +
                                        "<td>" +
                                        "<input type='hidden' class='input_class' name='skus[" + index + "].propIdStr' value='" + skuids[i] + "' />" +
                                        "<input type='text' class='input_class' name='skus[" + index + "].quality' />" +
                                        "</td>" +
                                        "<td><input  type='text' class='input_class' name='skus[" + index + "].price'  /></td>" +
                                        "</tr>";
                                }
                            }
                            $("#sku_table").append(tr_html);
                        } else {
                            // 删除行
                            $("#sku_table tbody tr").each(function(i, n) {
                                var class_val = $(n).attr("class");
//                                console.log(class_val);
                                if (class_val != undefined && class_val.indexOf(color_id) != -1) {
                                    $(n).remove();
                                }
                            });

                        }
                        if(len === 1){
                        	 $("#sku_table tr").each(function(i,n){
                        		 $("td:eq(1)",$(n)).addClass("hidden");
                        	 });
                        }
                        // 下标排序
                        $("#sku_table tbody tr").each(function(i, n) {
                            $(".input_class", $(n)).each(function(j, k) {
                                var old_name = $(k).attr("name");
                                var new_name = old_name.replace(/\d+/, i);
                                $(k).attr("name", new_name);
//                                console.log(new_name);
                            });
                        });
                    }


                    // 销售
                    function changeSaleProp(that) {
                        //rebuildtable();
                        var $this = $(that);

                        // 销售的id组合（尺码）
                        var sale_id = $this.val();

                        // 展示的名称
                        var input_next = $this.next().children("input").first();
                        var input_next_val = input_next.val();

                        if (that.checked) {

                            $("#sku_table tr").each(function(i, n) {
                                var length = $("td", $(n)).length;
                                // console.log(length);
                                if (length === 4 && $(n).attr("class") != "thead") {

                                    // 颜色id组合
                                    var color_id = $(n).attr("class").split(";")[0];

                                    // tr class组合
                                    var class_name = color_id + ";" + sale_id;

                                    // 处理td的跨行
                                    var row_td = $(n).children("td").first();
                                    var row_num = $.trim(row_td.attr("rowspan"));
                                    
                                    if(row_num === undefined||row_num === ""){
                                        row_num = 1;
                                    }
                                    var row_span = parseInt(row_num) + 1;
                                    row_td.attr("rowspan", row_span);

                                    // 追加行
                                    var tr_html = "<tr class='" + class_name + "'>" +
                                        "<td>" + input_next_val + "</td>" +
                                        "<td>" +
                                        "<input type='hidden' class='input_class' name='skus[0].propIdStr' value='" + class_name + "' />" +
                                        "<input type='text' class='input_class' name='skus[0].quality' />" +
                                        "</td>" +
                                        "<td><input  type='text' class='input_class' name='skus[0].price'  /></td>" +
                                        "</tr>";

                                    // 选中追加行
                                    //$(n).after(tr_html);
                                    var prev_tr_len = $(n).prevAll().length;
                                    var tr_goal_index = parseInt(row_num) + prev_tr_len;
                                    var next_tr_child_4 = $("tr:eq(" + tr_goal_index + ")", "#sku_table");
                                    next_tr_child_4.after(tr_html);
                                }

                            });

                            // 所有被删除完后，再添加行的处理
                            var len = $("#sku_table tr").length;
                            if (len === 1) {
                                $(".colorProp").each(function(i, n) {
                                    if (n.checked) {
                                        var color_id = $(n).val();
                                        var color_name = $(n).next().children("input").first().val();
                                        var skuid = color_id + ";" + sale_id;
                                        // 组合tr
                                        var html = "<tr class='" + skuid + "'>" +
                                            "<td rowspan='1'>" + color_name + "</td>" +
                                            "<td>" + input_next_val + "</td>" +
                                            "<td>" +
                                            "<input type='hidden' class='input_class' name='skus[0].propIdStr' value='" + skuid + "' />" +
                                            "<input type='text' class='input_class' name='skus[0].quality' />" +
                                            "</td>" +
                                            "<td><input  type='text' class='input_class' name='skus[0].price'  /></td>" +
                                            "</tr>";
                                        $("#sku_table").append(html);
                                    }
                                });
                            }



                        } else {
                            // 未选中删除行
                            $("#sku_table tbody tr").each(function(i, n) {

                                // 如果当前行为首行，就将表头移到下一行
                                if ($(n).children().length === 4) {

                                    if ($(n).attr("class").indexOf(sale_id) != -1) {

                                        var td_first = $(n).children("td:first");
                                        var row_span = td_first.attr("rowspan") * 1;
                                        td_first.attr("rowspan", row_span);
                                        var td_html = "<td rowspan='" + row_span + "'>" + $(n).children("td").first().html() + "</td>";
                                        $(n).next().children("td:first").before(td_html);
                                    }
                                }

                                // 删除
                                if ($(n).attr("class").indexOf(sale_id) != -1) {
                                    $(n).remove();

                                }
                            });

                            // 单元格跨行处理
                            $("#sku_table tr td[rowspan]").each(function(i, n) {
                                var num = $(n).prop("rowspan");
                                $(n).prop("rowspan", num * 1 - 1);
                            });

                        }

                        // 下标排序
                        $("#sku_table tbody tr").each(function(i, n) {
                            $(".input_class", $(n)).each(function(j, k) {
                                var old_name = $(k).attr("name");
                                var new_name = old_name.replace(/\d+/, i);
                                $(k).attr("name", new_name);
                            });
                        });

                    }