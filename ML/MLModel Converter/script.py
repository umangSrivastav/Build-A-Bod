import tensorflow as tf
import tfcoreml
from coremltools.proto import FeatureTypes_pb2 as _FeatureTypes_pb2
import coremltools

"""FIND GRAPH INFO"""
tf_model_path = "../model/tf_files/retrained_graph.pb"
with open(tf_model_path , 'rb') as f:
    serialized = f.read()
tf.reset_default_graph()
original_gdef = tf.GraphDef()
original_gdef.ParseFromString(serialized)

with tf.Graph().as_default() as g:
    tf.import_graph_def(original_gdef, name ='')
    ops = g.get_operations()
    N = len(ops)
    for i in [0,1,2,N-3,N-2,N-1]:
        print('\n\nop id {} : op type: "{}"'.format(str(i), ops[i].type))
        print('input(s):')
        for x in ops[i].inputs:
            print("name = {}, shape: {}, ".format(x.name, x.get_shape()))
        print('\noutput(s):'),
        for x in ops[i].outputs:
            print("name = {}, shape: {},".format(x.name, x.get_shape()))


""" CONVERT TF TO CORE ML """
# Model Shape
input_tensor_shapes = {"input:0":[1,224,224,3], "MobilenetV1/Conv2d_0/weights:0":[3, 3, 3, 16], "MobilenetV1/Conv2d_0/weights:0":[3, 3, 3, 16], "MobilenetV1/Conv2d_0/weights/read:0":[3, 3, 3, 16], "final_training_ops/weights/final_weights/read:0":[1001, 2], "final_training_ops/biases/final_biases/read:0":[2, 1]} 
# Input Name
image_input_name = ['input:0', 'MobilenetV1/Conv2d_0/weights:0', 'MobilenetV1/Conv2d_0/weights:0', 'MobilenetV1/Conv2d_0/weights/read:0', 'MobilenetV1/Conv2d_0/weights/read:0', 'final_training_ops/weights/final_weights/read:0', 'final_training_ops/biases/final_biases/read:0']
# Output CoreML model path
coreml_model_file = './myModel.mlmodel'
# Output name
output_tensor_names = ['final_result:0']
# Label file for classification
class_labels = 'retrained_labels.txt'

#Convert Process
coreml_model = tfcoreml.convert(
        tf_model_path=tf_model_path,
        mlmodel_path=coreml_model_file,
        input_name_shape_dict=input_tensor_shapes,
        output_feature_names=output_tensor_names,
        image_input_names = image_input_name,
        class_labels = class_labels)


# Get image pre-processing parameters of a saved CoreML model
spec = coremltools.models.utils.load_spec(coreml_model_file)
if spec.WhichOneof('Type') == 'neuralNetworkClassifier':
  nn = spec.neuralNetworkClassifier
if spec.WhichOneof('Type') == 'neuralNetwork':
  nn = spec.neuralNetwork  
if spec.WhichOneof('Type') == 'neuralNetworkRegressor':
  nn = spec.neuralNetworkRegressor

preprocessing = nn.preprocessing[0].scaler

inp = spec.description.input[0]
if inp.type.WhichOneof('Type') == 'imageType':
  colorspace = _FeatureTypes_pb2.ImageFeatureType.ColorSpace.Name(inp.type.imageType.colorSpace)


coreml_model = tfcoreml.convert(
        tf_model_path=tf_model_path,
        mlmodel_path=coreml_model_file,
        input_name_shape_dict=input_tensor_shapes,
        output_feature_names=output_tensor_names,
        image_input_names = image_input_name,
        class_labels = class_labels,
        red_bias = -1,
        green_bias = -1,
        blue_bias = -1,
        image_scale = 2.0/255.0)

