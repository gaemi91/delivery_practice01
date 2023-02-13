import 'dart:io';
import 'package:dio/dio.dart';

const ipEmulator = '10.0.2.2:3000';
const ipSimulator = '127.0.0.1:3000';
final ip = Platform.isMacOS ? ipSimulator : ipEmulator;

const Token_key_Access = 'accessToken';
const Token_key_Refresh = 'refreshToken';

final dio = Dio();


