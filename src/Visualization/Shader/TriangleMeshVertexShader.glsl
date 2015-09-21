#version 120

attribute vec3 vertex_position;
attribute vec3 vertex_color;
attribute vec3 vertex_normal;

varying vec3 vertex_position_world;
varying vec3 vertex_normal_camera;
varying vec3 eye_dir_camera;
varying vec3 light_dir_camera;
varying vec3 fragment_color;

uniform mat4 MVP;
uniform mat4 V;
uniform mat4 M;
uniform vec3 light_position_world;

void main()
{
	gl_Position =  MVP * vec4(vertex_position, 1);
	vertex_position_world = (M * vec4(vertex_position, 1)).xyz;

	vec3 vertex_position_camera = (V * M * vec4(vertex_position, 1)).xyz;
	eye_dir_camera = vec3(0, 0, 0) - vertex_position_camera;

	vec3 light_position_camera = (V * vec4(light_position_world, 1)).xyz;
	light_dir_camera = light_position_camera - vertex_position_camera;

	vertex_normal_camera = (V * M * vec4(vertex_normal, 0)).xyz;

	fragment_color = vertex_color;
}