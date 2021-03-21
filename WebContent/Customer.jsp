<div class="modal fade" id="modalRegisterForm" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header text-center">
        <h4 class="modal-title w-100 font-weight-bold">Customer Registration</h4>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body mx-3">
        <div class="md-form mb-5">
          <i class="fas fa-user prefix grey-text"></i>
          <input type="text" list="cust" id="t1" onkeypress="sendInfo()"  autocomplete="off" class="form-control validate"><div id="amit"> </div></input>
          <label data-error="wrong" data-success="right" for="orangeForm-name">Customer Name</label>
        </div>
      
        <div class="md-form mb-4">
          <i class="fas fa-lock prefix grey-text"></i>
          <input type="text" id="orangeForm-pass" class="form-control validate" name="mobile"/>
          <label data-error="wrong" data-success="right" for="orangeForm-pass">Customer Mobile No.</label>
        </div>

      </div>
      <div class="modal-footer d-flex justify-content-center">
        <button type="submit" value="addCustomer" class="btn btn-deep-orange">Add Customer</button>
        <button class="btn btn-deep-orange">Skip</button>
      </div>
    </div>
  </div>
</div>
