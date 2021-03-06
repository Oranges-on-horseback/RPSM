
local M = { }

function M.parse(arg)
    local cmd = torch.CmdLine()
    cmd:text()
    cmd:text(' ---------- General options ------------------------------------')
    cmd:text()
    cmd:option('-dataset',        'h3m', 'Dataset choice: mpii | flic')
    cmd:option('-dataDir',       '../data', 'Data directory')
    cmd:option('-expDir',         '../exp',  'Experiments directory')
    cmd:option('-expID',          'default', 'experiment id')
    cmd:option('-manualSeed',         -1, 'Manually set RNG seed')
    cmd:option('-GPU',                 1, 'Default preferred GPU, if set to -1: no GPU')
    cmd:option('-nThreads',            2, 'Number of data loading threads')
    cmd:text()
    cmd:text(' ---------- Model options --------------------------------------')
    cmd:text()
    cmd:option('-loadModel',      'none', 'Provide full path to a previously trained model')
    cmd:option('-continue',        false, 'Pick up where an experiment left off')
    cmd:option('-snapshot',            1, 'How often to take a snapshot of the model (0 = never)')
    
    cmd:option('-netType',        '', 'net defination')

    cmd:text()
    cmd:text(' ---------- Hyperparameter options -----------------------------')
    cmd:text()
    cmd:option('-LR',                1e-4, 'Learning rate')
    cmd:option('-LRstep',            0.0, 'Learning rate decay')
    cmd:option('-momentum',          0.0, 'Momentum')
    cmd:option('-weightDecay',       0.0, 'Weight decay')
    cmd:option('-optimMethod',   'adam', 'Optimization method: rmsprop | sgd | nag | adadelta')
    
    cmd:text()
    cmd:text(' ---------- Training options -----------------------------------')
    cmd:text()
    cmd:option('-nEpochs',           100, 'Total number of epochs to run')
    cmd:option('-trainIters',        -1, 'Number of train iterations per epoch')
    cmd:option('-trainBatch',          3, 'Mini-batch size')
    cmd:option('-validIters',         -1, 'Number of validation iterations per epoch')
    cmd:option('-validBatch',          1, 'Mini-batch size for validation')
    cmd:text()
    cmd:text(' ---------- Data options ---------------------------------------')
    cmd:text()
    cmd:option('-inputRes',          368, 'Input image resolution')
    cmd:option('-labelSize',          51, 'Output heatmap resolution')
    cmd:option('-trainH5Path',          '', 'Name of training data file')
    cmd:option('-validH5Path',          '', 'Name of validation file')
    cmd:option('-minScale',           0.9)
    cmd:option('-maxScale',           1.1)
    cmd:option('-no_substract_mean',      false, 'whether to substract 0.5 to [-.5, 0.5]')
    
    cmd:text(' ---------- RPSM options ---------------------------------------')
    cmd:text()
    cmd:option('-rho',                 3, 'number of cpm stages')
    cmd:option('-hiddenSize',        2048, 'number of joints')
    cmd:option('-machineType',       'Machine', 'machine type Machine | RPSMMachinePretrained')
    cmd:option('-feat_ind',         33, 'index of the shared 2d pose model')
    cmd:option('-num_ch',           128, 'img feature channel number')
    cmd:option('-np',                 17, 'number of joints')
    cmd:option('-img_feat_dim',     2048, 'the coarse feature extract img feat dim')
    cmd:option('-sharedModel',        '',        'shared model in 2D pose module')
    
    cmd:text('---------- Temporal pose estimation   ------------------------------')
    cmd:text()
    cmd:option('-maxFrames',         20,  'max frames to capture information')
    cmd:option('-rootImgFolder', '')
    cmd:option('-trainImgList', '')
    cmd:option('-validImgList', '')

    local opt = cmd:parse(arg or {})
    opt.expDir = paths.concat(opt.expDir, opt.dataset)
    opt.dataDir = paths.concat(opt.dataDir, opt.dataset)
    opt.save = paths.concat(opt.expDir, opt.expID)
    return opt
end

return M
