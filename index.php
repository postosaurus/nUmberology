<?php
 error_reporting(E_ALL);
 ini_set("display_errors", 1);
?>
<head>
  <style>
    #header_names {
      overflow-x: scroll;
      width: 95%;
      text-align: center;
      justify-content: center;
      flex-flow: row;
      display: flex
    }
    #header_names table {
      padding: 5px;
      padding-left: 50px;
    }
    #header_names table tr{
      min-width: 100%;
    }
    #header_names .name {
      font-size: 3em;
    }
    #header_names .name_value {
      font-size: 1em;
    }
    #header_names .name_sum {
      font-size: 1.15em;
    }
    #header_names .name_root {
      font-size: 1.5em;
      text-align: center;
    }

    #search_bar {
      border: 1px solid black;
      display: flex;
      justify-content: space-evenly;
    }
    #search_bar img {
      margin: 15px;
      width:125px;
      height: 125px;
    }
    #search_bar h1 {
      font-size: 75;
      margin: 15px;
      padding-top: 35px;
    }
    #search_bar form {
      padding-left: 75px;
      padding-top: 35px;
      display: flex;
      flex-flow: row;
      justify-content: flex-end;
    }
    #search_bar input, #search_bar select {
      /* padding-left: 1em; */
      margin-left: 1em;
    }

    #content {
      margin-left: inherit;
      border: 1px solid black;
      width: 96%;
      display: flex;
      flex-flow: row wrap;
      justify: space-evenly
    }

    #date_table {
      justify-content: space-around;
      padding-bottom: 30px;
    }
    #date_table th {
      font-size: 1.8em;
    }
    #date_table th:not(:first-of-type) {
      border-left: 1px solid black;
    }
    #date_table td {
      border-bottom: 1px solid black;
    }
    #date_table td:not(:first-of-type) {
      border-left: 1px solid black;
    }

    #expression_table {
      justify-content: space-evenly;
    }
    #expression {
      width: 25%;
    }

    #intensityDate {
      width: 25%;
    }
    #intensityDate td {
      min-width: 50px;
      min-height: 50px;
      height: 50px;
    }
    #intensityDate tr {
      min-height: 50px;
    }
    #intensityName {
      width: 25%;
    }
    #intensityName td {
      border-bottom: 1px solid black;
    }
    #intensityName th {
      border-bottom: 1px solid black;
      border-right: 1px solid black;
    }
    #intensityName .tablehead, .tablehead {
      border: 1px solid black;
    }
    #peak {
      display: flex;
      flex-direction: row;
      width: 65%;
      padding-top: 30px;
    }
    .container {
      border: 0px solid black;
      width: 95%;
      margin: 10px;
      padding: 5px;
      justify: center;
      flex-flow: row;
      display: flex;
      flex-wrap: wrap;
      justify: center;
    }
    .placeholder {
      width: 15%; height:30px;
    }
    div {
      padding-bottom: 10px;
      border: 0px solid black;
    }
    table {
      border: 0px solid black;
      text-align: center;
      padding-bottom: 10px;
    }

    #peak_image {
      background-image: url("images/peaks.png");
      background-repeat: round;
      min-width: 400px;
      min-height: 250px;
    }
    .hide {
      /* display: none; */
    }
    #basic_peak {
      text-align: center;
      display: flex;
      flex-direction: row;
      justify-content: space-between;
    }
    #basic_peak :first-child {
      text-align: left;
    }
    #basic_peak :last-child {
      text-align: right;
    }
    #peak_image {
      /* border: 1px solid black; */
      overflow: hidden;
      width: 350px;
      height: 220px;
    }
    #peak_image div {
       /* border: .1em solid black; */
       width: 20%;
       height: 20%%;
    }
    #peak_image .label {
      display: block;
      position: relative;
      text-align: center;
    }

    #foot {
      order: 25;
      border: 1px solid black;
      width: 96%;
      justify-content: center;
      align-self: center;
    }
    @media only screen and (max-width: 600px) {
      body {
        /* margin-left: 45px; */
      }
      #header_names table:first-child {
        /* padding-left: 150%; */
      }
      #header_names {
        width: 100%;
        padding-left:  100%;
        border: 1px solid black;
      }

      #search_bar {
        border: 1px solid black;
        display: flex;
        justify-content: center;
      }
      #search_bar img {
        /* margin: 15px; */
        width:125px;
        height: 125px;

      }
      #search_bar h1 {
        font-size: 1em;
        /* margin: 15px; */
        /* padding-top: 35px; */

      }
      #search_bar form {
        padding-left: 0px;
        padding-top: 0px;
        display: flex;
        flex-flow: column;
        justify-content: center;
      }
      #search_bar input, #search_bar select {
        max-width: 5em;

      }
      #content {
        border: 1px solid black;
        overflow: scroll;

      }

    }

  </style>
</head>
<body>
    <div id="search_bar" class="container">
    <a href="index.php" /><img src="images/Numertologie LOGO blau120px.png.png" /></a>
    <h1>nUmberology</h1>
    <form action="index.php" method="post">
      <input type="text" name="name" value="" placeholder="Fill in your name: ">
      <input type="text" name="day" value="" max="31" min="0" placeholder="dd" >
      <input type="text" name="month" value="" max="12" min="0" placeholder="mm">
      <input type="text" name="year" value="" placeholder="yy" >
      <select name="sexe">
        <option value="m">Male</option>
        <option value="f">Female</option>
      </select>

      <input type="submit" value="and go">
    </form>
    </div>
    <div id="content">
<?php
if( !empty($_POST) ){

   function CheckOutput($data, $name) {
     if($data[$name][$name] == $data[$name]['root']) {
       echo $data[$name][$name];
     } elseif ($data[$name][$name] == $data[$name]['digit']) {
       echo $data[$name][$name] . "/" . $data[$name]['root'];
     } else {
       echo $data[$name][$name] . "/" . $data[$name]['digit'];
     }
   }

   function CheckOutputName($data, $name, $show) {
     if ($data['value'.$name] == $data['root'.$name]){
       echo $data['root'.$name];
     } elseif($data['value'.$name] == $data['digit'.$name]) {
       echo $data['digit'.$name];
       if($show) {
         echo "/";
         echo "(". $data['root'.$name] . ")";
       }
     } else {
       echo $data['value'.$name];
       echo "/";
       echo $data['digit'.$name];
     }
   }

    $name = $_POST['name'];
    $day = $_POST['day'];
    $month = $_POST['month'];
    $year = $_POST['year'];
    $sexe = $_POST['sexe'];

    $command = "python3 ./main.py '". $name ."' ". $day ." ".$month." ".$year." ". $sexe;
    $output = shell_exec($command);
    $data = json_decode($output, true);

    // Debug
    // echo $output;
    echo "<pre style='display: none;'>";
    echo "<b>". $command . "</b><br>";
    foreach ($data as $key => $item) {
      if (is_array($item)){
        echo $key .":<br>";
        foreach ($item as $k => $value) {
          echo "  ".$k .": " . $value . "<br>";

        }
      } else {
      echo $key. ": ". $item ."<br>";
      }
    }
    echo "</pre>";
?>
    <!-- Name printing -->
    <div id="header_names">
      <?php
      foreach ($data['name'] as $key => $names) {
       ?>
          <table>
            <tr>
              <td class="name_root" colspan="<?= strlen($data['name'][$key]['name']) ?>">
                <?php
                CheckOutputName($data['name'][$key], '_vow', false);
                ?>
              </td>
            </tr>

            <tr>
              <?php foreach($data['name'][$key]['vow'] as $k => $l) { echo "<td class='name_value'>".$l."</td>";}?>
            </tr>

            <tr>
              <?php

              for($i = 0; $i < strlen($data['name'][$key]['name']); $i++) {
                echo "<td class='name'>". $data['name'][$key]['name'][$i] . "</td>";
                }
              ?>
            </tr>

            <tr>
              <?php foreach($data['name'][$key]['kons'] as $k => $l) { echo "<td class='name_value'>".$l."</td>";}?>
            </tr>
            <tr>
              <td class='name_sum' colspan="<?= strlen($data['name'][$key]['name']) ?>" >
                <?php
                CheckOutputName($data['name'][$key], '_kons', false);
                ?>
            </td>
            </tr>
            <tr>
              <td class="name_root" colspan="<?= strlen($data['name'][$key]['name']) ?>">
                &nbsp;
              </td>
            </tr>
            <tr>
              <td class="name_root" colspan="<?= strlen($data['name'][$key]['name']) ?>">
                <!-- <?= $data['name'][$key]['value'] ?>/<?= $data['name'][$key]['root'] ?> -->
                <?php
                CheckOutputName($data['name'][$key], '', true);
                ?>
              </td>
            </tr>
          </table>

        <?php
        }
         ?>

    </div>

    <!-- Date printed here -->
    <div id="date_table" class="container">
      <table style="order: 2; width: 45%;">
        <tr>
          <th><?= $data['day']['day'] ?></th>
          <th><?= $data['month']['month'] ?></th>
          <th><?= $data['year']['year'] ?></th>
        </tr>
         <td><?= $data['day']['digit'] ?></td>
         <td><?= $data['month']['digit'] ?></td>
         <td><?= $data['year']['sum'] ?>(<?= $data['year']['digit'] ?>)</td>
        <tr>
        </tr>
     </table>
    </div>

    <div id="expression_table" class="container">

    <!-- Expression table -->
     <table id="expression" style="order: 4;">
       <tr>
         <th colspan="4" class="tablehead">Table</th>
       </tr>
       <tr>
         <th>Lesson:</th>
         <td>
           <?php
          CheckOutput($data, 'lesson');
          ?>
         </td>
         <td></td>
         <td style='border: 1px solid red; border-radius: 10px;'>
           <?php
               if(isset($data['repeating_subelements_date'])) {
                 foreach ($data['repeating_subelements_date'] as $key => $element) {
                   echo "<span style='color: red;'>".$element . "</span> ";
                 }
               }
             ?>
           </td>
       </tr>
       <tr>
         <th style="border-bottom: 1px solid black">Sublesson:</th>
         <td colspan="2" style="border-bottom: 1px solid black">
           <?php
           CheckOutput($data, 'sublesson');
           ?>
         </td>
       </tr>
       <tr>
         <th>Expression:</th>
         <td colspan="2">
          <?php
          CheckOutput($data, 'expression');
          ?>
         </td>
       </tr>
       <tr>
         <th>Soul:</th>
         <td colspan="2">
        <?php
        CheckOutput($data, 'soul');
        ?>
        </td>
       </tr>
       <tr>
         <th style="border-bottom: 1px solid black">Ego:</th>
         <td style="border-bottom: 1px solid black">
          <?php
          CheckOutput($data, 'ego');
          ?>
        </td>
         <td></td>
         <td style='border: 1px solid red; border-radius: 10px;'> <span>
           <?php
           if(isset($data['repeating_subelements_name'])) {
             foreach ($data['repeating_subelements_name'] as $key => $element) {
               echo "<span style='color: red'>".$element . "</span> ";
             }
           }
           ?>
         </span></td>
       </tr>
       <tr>
         <th>Growth:</th>
         <td colspan="2">
           <?php
           CheckOutput($data, 'growth');
           ?>
         </td>
       </tr>
       <tr>
         <th>Challenge:</th>
         <td colspan="2"><?= $data['challenge'] ?></td>
       </tr>
       <tr>
         <th>Destiny:</th>
         <td colspan="2"><?= $data['name'][0]['digit'] ?></td>
       </tr>
       <tr>
         <th>Universal Year:</th>
         <td colspan="2"><?= $data['universal_year']['year'] ?>/<?= $data['universal_year']['digit'] ?></td>
       </tr>
       <tr>
         <th>Personal Year:</th>
         <td colspan="2"><?= $data['personal_year']['sum'] ?>/<?= $data['personal_year']['digit'] ?></td>
       </tr>
     </table>


    <!-- Intensity Date -->
     <table id="intensityDate" border="0" style="order:6;">
       <tr>
         <th class="tablehead" colspan="3">Intensity Date</th>
       </tr>
       <tr>
         <td style="border-bottom: 1px solid black; border-right: 1px solid black">
           <?php
           for($i = $data['intensity_date'][2]; $i >= 1; $i--) {
             echo "3";
           }
            ?>
         </td>
         <td style="border-bottom: 1px solid black;"><?php
         for($i = $data['intensity_date'][5]; $i >= 1; $i--) {
           echo "6";
         }
          ?></td>
         <td style="border-bottom: 1px solid black; border-left: 1px solid black">
           <?php
           for($i = $data['intensity_date'][8]; $i >= 1; $i--) {
             echo "9";
           }
            ?>
         </td>
       </tr>
       <tr>
         <td style="border-bottom: 1px solid black; border-right: 1px solid black">
           <?php
           for($i = $data['intensity_date'][1]; $i >= 1; $i--) {
             if($data['sexe'] == "female" and $i == $data['intensity_date'][1]) {
               echo "(2)";
             } else {
               echo "2";
             }
           }
            ?>
         </td>
         <td style="border-bottom: 1px solid black;">
           <?php
           for($i = $data['intensity_date'][4]; $i >= 1; $i--) {
             echo "5";
           }
            ?>
         </td>
         <td style="border-bottom: 1px solid black; border-left: 1px solid black">
           <?php
           for($i = $data['intensity_date'][7]; $i >= 1; $i--) {
             echo "8";
           }
            ?>
         </td>
       </tr>
       <tr>
         <td style=" border-right: 1px solid black">
           <?php
           for($i = $data['intensity_date'][0]; $i >= 1; $i--) {
             echo "1";
           }
           ?>
         </td>
         <td style="">
           <?php
           for($i = $data['intensity_date'][3]; $i >= 1; $i--) {
             echo "4";
           }
            ?>
         </td>
         <td style=" border-left: 1px solid black">
           <?php
           for($i = $data['intensity_date'][6]; $i >= 1; $i--) {
             echo "7";
           }
            ?>
         </td>
       </tr>
     </table>

    <!-- Intensity Name -->
     <table id="intensityName" style="order: 8;">
       <tr>
         <th class="tablehead" colspan="3">Intensity Name</th>
       </tr>
       <?php
       for($i = 1; $i <= 9; $i++) {
         echo "<tr><th>".$i."s: </th>";
         echo "<td>".$data['intensity_name'][$i-1]."</td>";
         if( $data['intensity_name'][$i-1] == 0) {
          echo "<td style='color: red'>KL</td>";
        }
         elseif ($data['intensity_name'][$i-1] < $data['average_intensity_name'][$i]['min']) {
          echo "<td>I-</td>";
        }
        elseif ($data['intensity_name'][$i-1] > $data['average_intensity_name'][$i]['max']) {
          echo "<td>I+</td>";
        } else {
          echo "<td style='color: blue'>ok</td>";
        }
       }
        ?>
     </table>

     <!-- Peaks image here -->
     <div id="peak_image" style="order: 11">
      <div class="label" style="left: 160px; top: 10px;"><?= $data['peaks'][3]['value'] ?></div>
      <div class="label" style="left: 80px; top: -18px;"><?= $data['peaks'][3]['age'] ?><br><?= $data['peaks'][3]['year'] ?><br></div>

      <div class="label" style="left: 160px; top: -10px;"><?= $data['peaks'][2]['value'] ?></div>
      <div class="label" style="left: 250px; top: -67px;"><?= $data['peaks'][2]['age'] ?><br><?= $data['peaks'][2]['year'] ?></div>

      <div class="label" style="left: 235px; top: -5px;"><?= $data['peaks'][1]['value'] ?></div>
      <div class="label" style="left: 320px; top: -60px;"><?= $data['peaks'][1]['age'] ?><br><?= $data['peaks'][1]['year'] ?></div>

      <div class="label" style="left: 85px; top: -80px;"><?= $data['peaks'][0]['value'] ?></div>
      <div class="label" style="left: 0px; top: -135px;"><?= $data['peaks'][0]['age'] ?><br><?= $data['peaks'][0]['year'] ?></div>


      <div class="label" style="left: -10px; top: -75px;"><?= $data['month']['root'] ?></div>
      <div class="label" style="left: 160px; top: -105px;"><?= $data['day']['root'] ?></div>
      <div class="label" style="left: 330px; top: -135px;"><?= $data['year']['root'] ?></div>
    </div>
<?php
}
?>

  </div>
<!-- </div> -->

  <!-- <div id="foot" class="content">
    2022 by posty
  </div> -->


</body>
