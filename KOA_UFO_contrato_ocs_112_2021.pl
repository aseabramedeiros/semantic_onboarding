% ===== KOA Combined Output | contract_id: contrato_ocs_112_2021 =====

% ===== 1) UFO Ontology =====
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY EM PROLOG
% Inspirada em UFO-L + UFO-S + Service Contract Ontology (Griffo et al., 2017)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% META-ESTRUTURA (TBox: classes, especializações, relações entre classes)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicados básicos de metamodelo
class(C).          % C é uma classe ontológica
subclass_of(C, P). % C é subclasse de P
disjoint(C1, C2).  % C1 e C2 são disjuntas conceitualmente

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Núcleo UFO-A / UFO-C simplificado
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(agent).           % agente (pessoa, organização etc.)
class(relator).         % relator genérico
class(moment).          % propriedade/momento (trope no sentido do UFO)

class(social_relator).
class(legal_relator).

subclass_of(social_relator, relator).
subclass_of(legal_relator, social_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LEGAL MOMENTS E LEGAL RELATORS (UFO-L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(legal_moment).
class(legal_entitlement).      % vantagens jurídicas
class(legal_burden_or_lack).  % ônus / falta de prerrogativa

subclass_of(legal_entitlement, legal_moment).
subclass_of(legal_burden_or_lack, legal_moment).

% Tipos de legal relators
class(simple_legal_relator).
class(complex_legal_relator).

subclass_of(simple_legal_relator, legal_relator).
subclass_of(complex_legal_relator, legal_relator).

% ---------------------------------------------------------------------------
% Right / Duty
% ---------------------------------------------------------------------------

class(right).
class(right_to_action).
class(right_to_omission).

class(duty).
class(duty_to_act).
class(duty_to_omit).

subclass_of(right, legal_entitlement).
subclass_of(right_to_action, right).
subclass_of(right_to_omission, right).

subclass_of(duty, legal_burden_or_lack).
subclass_of(duty_to_act, duty).
subclass_of(duty_to_omit, duty).

% ---------------------------------------------------------------------------
% NoRight / Permission
% ---------------------------------------------------------------------------

class(no_right).
class(no_right_to_action).
class(no_right_to_omission).

class(permission).
class(permission_to_act).
class(permission_to_omit).

subclass_of(no_right, legal_burden_or_lack).
subclass_of(no_right_to_action, no_right).
subclass_of(no_right_to_omission, no_right).

subclass_of(permission, legal_entitlement).
subclass_of(permission_to_act, permission).
subclass_of(permission_to_omit, permission).

% ---------------------------------------------------------------------------
% Power / Subjection (Liability)
% ---------------------------------------------------------------------------

class(power).
class(subjection).

subclass_of(power, legal_entitlement).
subclass_of(subjection, legal_burden_or_lack).

% ---------------------------------------------------------------------------
% Disability / Immunity
% ---------------------------------------------------------------------------

class(disability).
class(immunity).

subclass_of(disability, legal_burden_or_lack).
subclass_of(immunity, legal_entitlement).

% ---------------------------------------------------------------------------
% Liberty (liberdade desprotegida como complex legal relator)
% ---------------------------------------------------------------------------

class(liberty_relator).
subclass_of(liberty_relator, complex_legal_relator).

% ---------------------------------------------------------------------------
% Tipos de Simple Legal Relator (pares correlatos)
% ---------------------------------------------------------------------------

class(right_duty_relator).
class(noright_permission_relator).
class(power_subjection_relator).
class(disability_immunity_relator).

subclass_of(right_duty_relator, simple_legal_relator).
subclass_of(noright_permission_relator, simple_legal_relator).
subclass_of(power_subjection_relator, simple_legal_relator).
subclass_of(disability_immunity_relator, simple_legal_relator).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CORRELAÇÃO ENTRE LEGAL MOMENTS (Hohfeld + Alexy)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Correlatos em nível de classe
correlates(right_to_action,   duty_to_act).
correlates(duty_to_act,       right_to_action).

correlates(right_to_omission, duty_to_omit).
correlates(duty_to_omit,      right_to_omission).

correlates(permission_to_act,     no_right_to_action).
correlates(no_right_to_action,    permission_to_act).

correlates(permission_to_omit,    no_right_to_omission).
correlates(no_right_to_omission,  permission_to_omit).

correlates(power,      subjection).
correlates(subjection, power).

correlates(disability, immunity).
correlates(immunity,   disability).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE RELATIONS E SERVICE CONTRACTS (núcleo UFO-S simplificado)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

class(service_relation).
class(service_agreement).
class(legal_service_agreement).

subclass_of(service_agreement, service_relation).
subclass_of(legal_service_agreement, service_agreement).

% Papéis em relações de serviço
class(service_provider_role).
class(target_customer_role).
class(hired_service_provider_role).
class(service_customer_role).

subclass_of(hired_service_provider_role, service_provider_role).
subclass_of(service_customer_role,       target_customer_role).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SERVICE CONTRACT ONTOLOGY (Fig. 4 do artigo)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Em um Legal Service Agreement, cada parte tem Entitlements e Burdens/Lacks
class(hsp_entitlement).      % Hired Service Provider Entitlement
class(hsp_burden_or_lack).   % Hired Service Provider Burden/Lack
class(sc_entitlement).       % Service Customer Entitlement
class(sc_burden_or_lack).    % Service Customer Burden/Lack

subclass_of(hsp_entitlement, legal_entitlement).
subclass_of(sc_entitlement,  legal_entitlement).

subclass_of(hsp_burden_or_lack, legal_burden_or_lack).
subclass_of(sc_burden_or_lack,  legal_burden_or_lack).

% Composição: um Legal Service Agreement é composto de legal moments
% associados a cada papel (provider x customer).
relator_component(legal_service_agreement, hsp_entitlement).
relator_component(legal_service_agreement, hsp_burden_or_lack).
relator_component(legal_service_agreement, sc_entitlement).
relator_component(legal_service_agreement, sc_burden_or_lack).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ESQUEMA PARA INSTÂNCIAS (ABox): AGENTES, ACORDOS, CLÁUSULAS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% instance_of(Instancia, Classe).
% Você vai usar isso para criar indivíduos (contratos, cláusulas, agentes...).

:- dynamic instance_of/2.
:- dynamic plays_role/3.
:- dynamic legal_relation_instance/4.
:- dynamic clause_of/2.

% plays_role(Agente, Papel, Acordo).
% Ex.: plays_role(aws, hired_service_provider_role, aws_sns_agreement).
%      plays_role(cliente_x, service_customer_role, aws_sns_agreement).
plays_role(Agent, Role, Agreement).

% clause_of(ClauseId, Agreement).
% ClauseId é uma cláusula (ou grupo de cláusulas) de um acordo específico.
clause_of(ClauseId, Agreement).

% legal_relation_instance(ClauseId, LegalMoment, Bearer, Action).
%
% ClauseId   - identificador da cláusula
% LegalMoment- classe do momento jurídico (duty_to_omit, power, immunity...)
% Bearer     - quem tem esse momento (agente ou papel)
% Action     - ação/omissão ou descrição da conduta
%
% Exemplos (para você popular depois, inspirados no artigo):
% legal_relation_instance(clause_17_1, duty_to_omit, customer, share_service_with_third_parties).
% legal_relation_instance(clause_17_1, right_to_omission, provider, share_service_with_third_parties).

legal_relation_instance(ClauseId, LegalMomentClass, Bearer, Action) :-
    clause_of(ClauseId, _Agreement),
    class(LegalMomentClass),
    (   atom(Bearer)
    ;   plays_role(Bearer, _, _)
    ),
    atom(Action).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% REGRAS AUXILIARES
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% fecho transitivo de subclass_of/2
subclass_of_trans(C, P) :-
    subclass_of(C, P).
subclass_of_trans(C, P) :-
    subclass_of(C, X),
    subclass_of_trans(X, P).

% is_a(Inst, Classe) — verifica se Inst é instância (direta ou indireta) de Classe
is_a(Inst, Classe) :-
    instance_of(Inst, C0),
    (   C0 = Classe
    ;   subclass_of_trans(C0, Classe)
    ).

% um legal_moment é um entitlement se a classe dele cai abaixo de legal_entitlement
is_entitlement(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_entitlement).

% um legal_moment é um burden/lack se cai abaixo de legal_burden_or_lack
is_burden_or_lack(Inst) :-
    instance_of(Inst, C),
    subclass_of_trans(C, legal_burden_or_lack).

% Dado um LegalMomentClass, encontrar seu correlato (em termos de classe)
correlative_class(LMClass, CorrelateClass) :-
    correlates(LMClass, CorrelateClass).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% FIM DA ONTOLOGIA BASE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% ===== 2) Generated UFO ABox =====
% UFO-only grounding generated from: KOA_Contrato_OCS_112_2021_-_Oi_(Link_Bloomberg_DC_principal).pl
% contract_id: contrato_ocs_112_2021

instance_of(contrato_ocs_112_2021, legal_service_agreement).

instance_of(banco_nacional_de_desenvolvimento_economico_e_social_bndes, agent).
instance_of(oi_s_a_em_recuperacao_judicial, agent).

plays_role(banco_nacional_de_desenvolvimento_economico_e_social_bndes, service_customer_role, contrato_ocs_112_2021).
plays_role(oi_s_a_em_recuperacao_judicial, hired_service_provider_role, contrato_ocs_112_2021).

clause_of(clausula_primeira_objeto, contrato_ocs_112_2021).
clause_of(clausula_segunda_vigencia, contrato_ocs_112_2021).
clause_of(clausula_terceira_local_prazo_condicoes_execucao_objeto, contrato_ocs_112_2021).
clause_of(clausula_quarta_niveis_servico, contrato_ocs_112_2021).
clause_of(clausula_quinta_recebimento_objeto, contrato_ocs_112_2021).
clause_of(clausula_sexta_preco, contrato_ocs_112_2021).
clause_of(clausula_setima_pagamento, contrato_ocs_112_2021).
clause_of(clausula_oitava_equilibrio_economico_financeiro_contrato, contrato_ocs_112_2021).
clause_of(clausula_decima_garantia_contratual, contrato_ocs_112_2021).
clause_of(clausula_decima_primeira_obrigações_contratado, contrato_ocs_112_2021).
clause_of(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, contrato_ocs_112_2021).
clause_of(clausula_decima_terceira_sigilo_das_informações, contrato_ocs_112_2021).
clause_of(clausula_decima_quarta_acesso_protecao_dados_pessoais, contrato_ocs_112_2021).
clause_of(clausula_decima_quinta_obrigações_bndes, contrato_ocs_112_2021).
clause_of(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, contrato_ocs_112_2021).
clause_of(clausula_decima_setima_penalidades, contrato_ocs_112_2021).
clause_of(clausula_decima_oitava_alteracoes_contratuais, contrato_ocs_112_2021).
clause_of(clausula_decima_nona_extincao_contrato, contrato_ocs_112_2021).
clause_of(clausula_vigesima_disposicoes_finais, contrato_ocs_112_2021).
clause_of(clausula_vigesima_primeira_foro, contrato_ocs_112_2021).
clause_of(clausula_nona_matriz_riscos, contrato_ocs_112_2021).

legal_relation_instance(clausula_primeira_objeto, duty_to_act, oi_s_a_em_recuperacao_judicial, provide_data_communication_service).
legal_relation_instance(clausula_primeira_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_data_communication_service).
legal_relation_instance(clausula_segunda_vigencia, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_implementation).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, oi_s_a_em_recuperacao_judicial, begin_implementation).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, oi_s_a_em_recuperacao_judicial, complete_implementation).
legal_relation_instance(clausula_segunda_vigencia, duty_to_act, oi_s_a_em_recuperacao_judicial, provide_data_communication_service).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, duty_to_act, oi_s_a_em_recuperacao_judicial, execute_contract_subject).
legal_relation_instance(clausula_terceira_local_prazo_condicoes_execucao_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, expect_contract_subject_execution).
legal_relation_instance(clausula_quarta_niveis_servico, duty_to_act, oi_s_a_em_recuperacao_judicial, execute_services_according_to_standards).
legal_relation_instance(clausula_quarta_niveis_servico, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, apply_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_price_reduction).
legal_relation_instance(clausula_quarta_niveis_servico, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, require_execution_to_standards).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_object_receipt).
legal_relation_instance(clausula_quinta_recebimento_objeto, duty_to_act, unknown, support_object_receipt).
legal_relation_instance(clausula_sexta_preco, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, pay_contracted_value).
legal_relation_instance(clausula_sexta_preco, right_to_action, oi_s_a_em_recuperacao_judicial, receive_payment).
legal_relation_instance(clausula_sexta_preco, duty_to_act, oi_s_a_em_recuperacao_judicial, bear_burdens_of_quantification_errors).
legal_relation_instance(clausula_sexta_preco, immunity, banco_nacional_de_desenvolvimento_economico_e_social_bndes, avoid_indemnification_for_partial_demand).
legal_relation_instance(clausula_sexta_preco, no_right_to_action, oi_s_a_em_recuperacao_judicial, demand_indemnification_for_partial_demand).
legal_relation_instance(clausula_sexta_preco, subjection, oi_s_a_em_recuperacao_judicial, suffer_proportional_value_reduction).
legal_relation_instance(clausula_sexta_preco, duty_to_act, oi_s_a_em_recuperacao_judicial, execute_contract_object).
legal_relation_instance(clausula_sexta_preco, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, receive_contract_object).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, effect_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, oi_s_a_em_recuperacao_judicial, present_fiscal_document).
legal_relation_instance(clausula_setima_pagamento, permission_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_payment_to_subcontractor).
legal_relation_instance(clausula_setima_pagamento, right_to_action, oi_s_a_em_recuperacao_judicial, receive_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, oi_s_a_em_recuperacao_judicial, provide_supporting_documents).
legal_relation_instance(clausula_setima_pagamento, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, deduct_from_payment).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, oi_s_a_em_recuperacao_judicial, issue_invoice_according_to_municipality).
legal_relation_instance(clausula_setima_pagamento, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_payment_with_interest).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, oi_s_a_em_recuperacao_judicial, request_price_readjustment).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, right_to_action, oi_s_a_em_recuperacao_judicial, request_price_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, revise_prices).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_price_reduction).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, subjection, oi_s_a_em_recuperacao_judicial, provide_requested_information).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_act, oi_s_a_em_recuperacao_judicial, request_price_adjustment_or_revision).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, duty_to_omit, oi_s_a_em_recuperacao_judicial, omit_request_after_deadline).
legal_relation_instance(clausula_oitava_equilibrio_economico_financeiro_contrato, no_right_to_action, oi_s_a_em_recuperacao_judicial, request_price_adjustment_or_revision_after_deadline).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, oi_s_a_em_recuperacao_judicial, provide_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, oi_s_a_em_recuperacao_judicial, obtain_guarantor_agreement).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, oi_s_a_em_recuperacao_judicial, obtain_new_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, duty_to_act, oi_s_a_em_recuperacao_judicial, complement_or_renew_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contractual_guarantee).
legal_relation_instance(clausula_decima_garantia_contratual, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extend_guarantee_period).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, maintain_qualification_conditions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, communicate_penalty_imposition).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, repair_contract_object).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, repair_damages_to_bndes).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, pay_taxes_and_fees).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, exclude_from_simples_nacional).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, obey_bndes_instructions).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, designate_representative).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, maintain_organized_equipment).
legal_relation_instance(clausula_decima_primeira_obrigações_contratado, duty_to_act, oi_s_a_em_recuperacao_judicial, uninstall_infrastructure).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, oi_s_a_em_recuperacao_judicial, refrain_from_offering_undue_advantage).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, oi_s_a_em_recuperacao_judicial, prevent_favoritism).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_omit, oi_s_a_em_recuperacao_judicial, avoid_allocating_family_members).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, oi_s_a_em_recuperacao_judicial, observe_bndes_code_of_ethics).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, oi_s_a_em_recuperacao_judicial, adopt_good_environmental_practices).
legal_relation_instance(clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, maintain_integrity).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, oi_s_a_em_recuperacao_judicial, maintain_confidentiality).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, oi_s_a_em_recuperacao_judicial, provide_signature).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, duty_to_act, oi_s_a_em_recuperacao_judicial, orient_professionals).
legal_relation_instance(clausula_decima_terceira_sigilo_das_informações, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, request_signature).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, adopt_correct_security_measures).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oi_s_a_em_recuperacao_judicial, follow_bndes_instructions).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, right_of_regress).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oi_s_a_em_recuperacao_judicial, provide_data_access).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oi_s_a_em_recuperacao_judicial, inform_bndes_requests).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oi_s_a_em_recuperacao_judicial, maintain_data_processing_records).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oi_s_a_em_recuperacao_judicial, communicate_data_breach).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_act, oi_s_a_em_recuperacao_judicial, eliminate_personal_data).
legal_relation_instance(clausula_decima_quarta_acesso_protecao_dados_pessoais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, omit_sharing_data_without_authorization).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, make_payments_to_contracted_party).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, right_to_action, oi_s_a_em_recuperacao_judicial, receive_payments_from_bndes).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_manager).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_contract_inspector).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, designate_receipt_committee).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_documents).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, provide_information).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_instructions).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_investigation).
legal_relation_instance(clausula_decima_quinta_obrigações_bndes, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, communicate_penalty).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, oi_s_a_em_recuperacao_judicial, not_cede_contract).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, no_right_to_action, oi_s_a_em_recuperacao_judicial, not_issue_credit_title).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, oi_s_a_em_recuperacao_judicial, present_supporting_documents).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, oi_s_a_em_recuperacao_judicial, present_confidentiality_terms).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, oi_s_a_em_recuperacao_judicial, execute_contract_adequately).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, oi_s_a_em_recuperacao_judicial, merge_acquire_split).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, duty_to_act, oi_s_a_em_recuperacao_judicial, maintain_contract_conditions).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, permission_to_act, oi_s_a_em_recuperacao_judicial, subcontract_last_mile).
legal_relation_instance(clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, subjection, oi_s_a_em_recuperacao_judicial, contracted_party_subject_to_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, impose_penalties).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, oi_s_a_em_recuperacao_judicial, request_reconsideration_of_penalty).
legal_relation_instance(clausula_decima_setima_penalidades, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, extinguish_contract).
legal_relation_instance(clausula_decima_setima_penalidades, right_to_action, oi_s_a_em_recuperacao_judicial, judicial_collection_of_debt).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_omit, banco_nacional_de_desenvolvimento_economico_e_social_bndes, refrain_from_denaturing_contract_purpose).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, formalize_contract_amendment).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, duty_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, compensate_damages_for_refusal_to_amend).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_contract_amendment).
legal_relation_instance(clausula_decima_oitava_alteracoes_contratuais, subjection, banco_nacional_de_desenvolvimento_economico_e_social_bndes, subject_to_paying_damages_for_unjustified_refusal).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_bankruptcy).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_inability).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_cessao).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_inidonea).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_suspensao_licitar).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_ato_lesivo).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_dissolucao).
legal_relation_instance(clausula_decima_nona_extincao_contrato, subjection, oi_s_a_em_recuperacao_judicial, be_subject_to_termination_forca_maior).
legal_relation_instance(clausula_decima_nona_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_consensually).
legal_relation_instance(clausula_decima_nona_extincao_contrato, power, banco_nacional_de_desenvolvimento_economico_e_social_bndes, terminate_contract_due_breach).
legal_relation_instance(clausula_vigesima_disposicoes_finais, permission_to_act, banco_nacional_de_desenvolvimento_economico_e_social_bndes, exercise_rights).
legal_relation_instance(clausula_vigesima_disposicoes_finais, no_right_to_action, banco_nacional_de_desenvolvimento_economico_e_social_bndes, demand_strict_compliance).
legal_relation_instance(clausula_vigesima_primeira_foro, power, unknown, choose_rio_de_janeiro_court).
legal_relation_instance(clausula_vigesima_primeira_foro, no_right_to_action, unknown, choose_other_court).
legal_relation_instance(clausula_nona_matriz_riscos, duty_to_act, oi_s_a_em_recuperacao_judicial, bear_risks).
legal_relation_instance(clausula_nona_matriz_riscos, subjection, oi_s_a_em_recuperacao_judicial, subject_to_risk_allocation).

% --- Action catalog (local to this contract grounding) ---
action_type(adopt_correct_security_measures).
action_label(adopt_correct_security_measures, 'Adopt security measures').
action_type(adopt_good_environmental_practices).
action_label(adopt_good_environmental_practices, 'Adopt good environmental practices').
action_type(adopt_sustainability_practices).
action_label(adopt_sustainability_practices, 'Adopt sustainability practices').
action_type(apply_price_reduction).
action_label(apply_price_reduction, 'Apply price reduction for non-compliance').
action_type(attend_bndes_requests).
action_label(attend_bndes_requests, 'Attend BNDES requests').
action_type(avoid_allocating_family_members).
action_label(avoid_allocating_family_members, 'Avoid allocating family members').
action_type(avoid_indemnification_for_partial_demand).
action_label(avoid_indemnification_for_partial_demand, 'Avoid indemnification for partial demand').
action_type(be_subject_to_penalties).
action_label(be_subject_to_penalties, 'Be subject to penalties').
action_type(be_subject_to_price_reduction).
action_label(be_subject_to_price_reduction, 'Subject to price reduction').
action_type(be_subject_to_termination_ato_lesivo).
action_label(be_subject_to_termination_ato_lesivo, 'Subject to termination ato lesivo').
action_type(be_subject_to_termination_bankruptcy).
action_label(be_subject_to_termination_bankruptcy, 'Subject to termination for bankruptcy').
action_type(be_subject_to_termination_cessao).
action_label(be_subject_to_termination_cessao, 'Subject to termination for assignment').
action_type(be_subject_to_termination_dissolucao).
action_label(be_subject_to_termination_dissolucao, 'Subject to termination dissolucao').
action_type(be_subject_to_termination_due_breach).
action_label(be_subject_to_termination_due_breach, 'Subject to termination for breach').
action_type(be_subject_to_termination_forca_maior).
action_label(be_subject_to_termination_forca_maior, 'Subject to termination for forca maior').
action_type(be_subject_to_termination_inability).
action_label(be_subject_to_termination_inability, 'Subject to termination lose ability').
action_type(be_subject_to_termination_inidonea).
action_label(be_subject_to_termination_inidonea, 'Subject to termination inidonea').
action_type(be_subject_to_termination_suspensao_licitar).
action_label(be_subject_to_termination_suspensao_licitar, 'Subject to termination suspensao licitar').
action_type(be_subject_to_termination_suspension).
action_label(be_subject_to_termination_suspension, 'Subject to termination after suspension').
action_type(bear_burdens_of_quantification_errors).
action_label(bear_burdens_of_quantification_errors, 'Bear burdens of quantification errors').
action_type(bear_risks).
action_label(bear_risks, 'Bear allocated risks').
action_type(begin_implementation).
action_label(begin_implementation, 'Begin implementation').
action_type(bndes_request).
action_label(bndes_request, 'Attend to BNDES requests').
action_type(choose_other_court).
action_label(choose_other_court, 'Choose another court').
action_type(choose_rio_de_janeiro_court).
action_label(choose_rio_de_janeiro_court, 'Choose Rio court').
action_type(communicate_data_breach).
action_label(communicate_data_breach, 'Communicate data breach').
action_type(communicate_instructions).
action_label(communicate_instructions, 'Communicate instructions').
action_type(communicate_investigation).
action_label(communicate_investigation, 'Communicate investigation').
action_type(communicate_penalty).
action_label(communicate_penalty, 'Communicate penalty').
action_type(communicate_penalty_imposition).
action_label(communicate_penalty_imposition, 'Communicate penalty').
action_type(compensate_damages_for_refusal_to_amend).
action_label(compensate_damages_for_refusal_to_amend, 'Compensate damages').
action_type(complement_or_renew_guarantee).
action_label(complement_or_renew_guarantee, 'Complement/renew guarantee').
action_type(complete_implementation).
action_label(complete_implementation, 'Complete implementation').
action_type(comply_with_contract_terms).
action_label(comply_with_contract_terms, 'Comply with contract terms').
action_type(comply_with_laws).
action_label(comply_with_laws, 'Comply with laws').
action_type(contracted_party_subject_to_penalties).
action_label(contracted_party_subject_to_penalties, 'Subject to penalties').
action_type(deduct_from_payment).
action_label(deduct_from_payment, 'Deduct from payment').
action_type(demand_contract_amendment).
action_label(demand_contract_amendment, 'Demand contract amendment').
action_type(demand_contractual_guarantee).
action_label(demand_contractual_guarantee, 'Demand guarantee').
action_type(demand_implementation).
action_label(demand_implementation, 'Demand implementation').
action_type(demand_indemnification_for_partial_demand).
action_label(demand_indemnification_for_partial_demand, 'Demand indemnification for partial demand').
action_type(demand_strict_compliance).
action_label(demand_strict_compliance, 'Demand strict compliance').
action_type(designate_contract_inspector).
action_label(designate_contract_inspector, 'Designate contract inspector').
action_type(designate_contract_manager).
action_label(designate_contract_manager, 'Designate contract manager').
action_type(designate_receipt_committee).
action_label(designate_receipt_committee, 'Designate receipt committee').
action_type(designate_representative).
action_label(designate_representative, 'Designate representative').
action_type(effect_object_receipt).
action_label(effect_object_receipt, 'Effect object receipt').
action_type(effect_payment).
action_label(effect_payment, 'Effect payment').
action_type(eliminate_personal_data).
action_label(eliminate_personal_data, 'Eliminate personal data').
action_type(ensure_security_compliance).
action_label(ensure_security_compliance, 'Ensure security compliance').
action_type(exclude_from_simples_nacional).
action_label(exclude_from_simples_nacional, 'Exclude from Simples Nacional').
action_type(execute_contract_adequately).
action_label(execute_contract_adequately, 'Execute contract adequately').
action_type(execute_contract_object).
action_label(execute_contract_object, 'Execute contract object').
action_type(execute_contract_subject).
action_label(execute_contract_subject, 'Execute contract subject').
action_type(execute_services_according_to_standards).
action_label(execute_services_according_to_standards, 'Execute services to standards').
action_type(exercise_rights).
action_label(exercise_rights, 'Exercise rights').
action_type(expect_contract_subject_execution).
action_label(expect_contract_subject_execution, 'Expect contract subject execution').
action_type(extend_guarantee_period).
action_label(extend_guarantee_period, 'Extend guarantee period').
action_type(extinguish_contract).
action_label(extinguish_contract, 'Extinguish contract').
action_type(follow_bndes_instructions).
action_label(follow_bndes_instructions, 'Follow BNDES instructions').
action_type(formalize_contract_amendment).
action_label(formalize_contract_amendment, 'Formalize contract amendment').
action_type(guarantee_no_copyright_infringement).
action_label(guarantee_no_copyright_infringement, 'Guarantee no copyright infringement').
action_type(identify_employees).
action_label(identify_employees, 'Identify employees').
action_type(impede_employee_participation).
action_label(impede_employee_participation, 'Prevent employee participation').
action_type(implement_permanent_supervision).
action_label(implement_permanent_supervision, 'Implement permanent supervision').
action_type(impose_penalties).
action_label(impose_penalties, 'Impose penalties').
action_type(indicate_contact_info).
action_label(indicate_contact_info, 'Indicate contact info').
action_type(inform_abnormalities).
action_label(inform_abnormalities, 'Inform abnormalities').
action_type(inform_bndes_requests).
action_label(inform_bndes_requests, 'Inform BNDES of requests').
action_type(issue_invoice_according_to_municipality).
action_label(issue_invoice_according_to_municipality, 'Issue invoice according to municipality').
action_type(judicial_collection_of_debt).
action_label(judicial_collection_of_debt, 'Cobrança judicial').
action_type(maintain_confidentiality).
action_label(maintain_confidentiality, 'Maintain confidentiality').
action_type(maintain_contract_conditions).
action_label(maintain_contract_conditions, 'Maintain contract conditions').
action_type(maintain_data_processing_records).
action_label(maintain_data_processing_records, 'Maintain data records').
action_type(maintain_escalation_list).
action_label(maintain_escalation_list, 'Maintain escalation list').
action_type(maintain_integrity).
action_label(maintain_integrity, 'Maintain integrity').
action_type(maintain_organized_equipment).
action_label(maintain_organized_equipment, 'Maintain organized equipment').
action_type(maintain_qualification_conditions).
action_label(maintain_qualification_conditions, 'Maintain qualification conditions').
action_type(make_payments_to_contracted_party).
action_label(make_payments_to_contracted_party, 'Make payments').
action_type(merge_acquire_split).
action_label(merge_acquire_split, 'Merge/Acquire/Split').
action_type(not_cede_contract).
action_label(not_cede_contract, 'Not cede contract').
action_type(not_issue_credit_title).
action_label(not_issue_credit_title, 'Not issue credit title').
action_type(not_perform_reverse_engineering).
action_label(not_perform_reverse_engineering, 'Not perform reverse engineering').
action_type(notify_potential_risks).
action_label(notify_potential_risks, 'Notify potential risks').
action_type(obey_bndes_instructions).
action_label(obey_bndes_instructions, 'Obey BNDES instructions').
action_type(observe_bndes_code_of_ethics).
action_label(observe_bndes_code_of_ethics, 'Observe BNDES code of ethics').
action_type(obtain_guarantor_agreement).
action_label(obtain_guarantor_agreement, 'Obtain guarantor agreement').
action_type(obtain_information).
action_label(obtain_information, 'Obtain information').
action_type(obtain_new_guarantee).
action_label(obtain_new_guarantee, 'Obtain new guarantee').
action_type(omit_payment_to_subcontractor).
action_label(omit_payment_to_subcontractor, 'Omit payment to subcontractor').
action_type(omit_request_after_deadline).
action_label(omit_request_after_deadline, 'Omit request after deadline').
action_type(omit_sharing_data_without_authorization).
action_label(omit_sharing_data_without_authorization, 'Do not share data without authorization').
action_type(orient_professionals).
action_label(orient_professionals, 'Orient professionals').
action_type(pay_contracted_value).
action_label(pay_contracted_value, 'Pay contracted value').
action_type(pay_taxes_and_fees).
action_label(pay_taxes_and_fees, 'Pay taxes and fees').
action_type(permit_inspections).
action_label(permit_inspections, 'Permit inspections').
action_type(present_confidentiality_terms).
action_label(present_confidentiality_terms, 'Present confidentiality terms').
action_type(present_dif).
action_label(present_dif, 'Present DIF').
action_type(present_fiscal_document).
action_label(present_fiscal_document, 'Present fiscal document').
action_type(present_supporting_documents).
action_label(present_supporting_documents, 'Present supporting documents').
action_type(prevent_favoritism).
action_label(prevent_favoritism, 'Prevent favoritism').
action_type(provide_contractual_guarantee).
action_label(provide_contractual_guarantee, 'Provide contractual guarantee').
action_type(provide_data_access).
action_label(provide_data_access, 'Provide data access').
action_type(provide_data_communication_service).
action_label(provide_data_communication_service, 'Provide data communication service').
action_type(provide_documents).
action_label(provide_documents, 'Provide documents').
action_type(provide_information).
action_label(provide_information, 'Provide information').
action_type(provide_necessary_information).
action_label(provide_necessary_information, 'Provide necessary information').
action_type(provide_new_installations).
action_label(provide_new_installations, 'Provide new installations').
action_type(provide_payment_with_interest).
action_label(provide_payment_with_interest, 'Provide payment with interest').
action_type(provide_representative_info).
action_label(provide_representative_info, 'Provide representative info').
action_type(provide_requested_information).
action_label(provide_requested_information, 'Provide requested information').
action_type(provide_signature).
action_label(provide_signature, 'Provide signature').
action_type(provide_supporting_documents).
action_label(provide_supporting_documents, 'Provide supporting documents').
action_type(receive_contract_object).
action_label(receive_contract_object, 'Receive contract object').
action_type(receive_data_communication_service).
action_label(receive_data_communication_service, 'Receive data communication service').
action_type(receive_instructions).
action_label(receive_instructions, 'Receive instructions').
action_type(receive_investigation).
action_label(receive_investigation, 'Receive investigation notice').
action_type(receive_payment).
action_label(receive_payment, 'Receive payment').
action_type(receive_payments_from_bndes).
action_label(receive_payments_from_bndes, 'Receive payments').
action_type(receive_penalty_notice).
action_label(receive_penalty_notice, 'Receive penalty notice').
action_type(refrain_from_denaturing_contract_purpose).
action_label(refrain_from_denaturing_contract_purpose, 'Refrain from denaturing contract').
action_type(refrain_from_offering_undue_advantage).
action_label(refrain_from_offering_undue_advantage, 'Refrain from offering undue advantage').
action_type(repair_contract_object).
action_label(repair_contract_object, 'Repair contract object').
action_type(repair_damages_to_bndes).
action_label(repair_damages_to_bndes, 'Repair damages to BNDES').
action_type(request_documents).
action_label(request_documents, 'Request documents').
action_type(request_price_adjustment_or_revision).
action_label(request_price_adjustment_or_revision, 'Request price adjustment/revision').
action_type(request_price_adjustment_or_revision_after_deadline).
action_label(request_price_adjustment_or_revision_after_deadline, 'No right to request adjustment/revision after deadline').
action_type(request_price_readjustment).
action_label(request_price_readjustment, 'Request price readjustment').
action_type(request_price_reduction).
action_label(request_price_reduction, 'Request price reduction').
action_type(request_price_revision).
action_label(request_price_revision, 'Request price revision').
action_type(request_reconsideration_of_penalty).
action_label(request_reconsideration_of_penalty, 'Request penalty reconsideration').
action_type(request_signature).
action_label(request_signature, 'Request signature').
action_type(require_execution_to_standards).
action_label(require_execution_to_standards, 'Require service execution to standards').
action_type(return_resources).
action_label(return_resources, 'Return resources').
action_type(revise_prices).
action_label(revise_prices, 'Revise prices').
action_type(right_of_regress).
action_label(right_of_regress, 'Right of regress').
action_type(subcontract_last_mile).
action_label(subcontract_last_mile, 'Subcontract last mile').
action_type(subject_to_paying_damages_for_unjustified_refusal).
action_label(subject_to_paying_damages_for_unjustified_refusal, 'Subject to damages for refusal').
action_type(subject_to_risk_allocation).
action_label(subject_to_risk_allocation, 'Subject to risk allocation').
action_type(suffer_proportional_value_reduction).
action_label(suffer_proportional_value_reduction, 'Suffer proportional value reduction').
action_type(support_object_receipt).
action_label(support_object_receipt, 'Support object receipt').
action_type(terminate_contract_ato_lesivo).
action_label(terminate_contract_ato_lesivo, 'Terminate contract ato lesivo').
action_type(terminate_contract_bankruptcy).
action_label(terminate_contract_bankruptcy, 'Terminate contract for bankruptcy').
action_type(terminate_contract_cessao).
action_label(terminate_contract_cessao, 'Terminate contract for assignment').
action_type(terminate_contract_consensually).
action_label(terminate_contract_consensually, 'Terminate contract consensually').
action_type(terminate_contract_dissolucao).
action_label(terminate_contract_dissolucao, 'Terminate contract dissolucao').
action_type(terminate_contract_due_breach).
action_label(terminate_contract_due_breach, 'Terminate contract due to breach').
action_type(terminate_contract_forca_maior).
action_label(terminate_contract_forca_maior, 'Terminate contract for forca maior').
action_type(terminate_contract_inability).
action_label(terminate_contract_inability, 'Terminate contract lose ability').
action_type(terminate_contract_inidonea).
action_label(terminate_contract_inidonea, 'Terminate contract inidonea').
action_type(terminate_contract_no_liberation).
action_label(terminate_contract_no_liberation, 'Terminate contract no liberation').
action_type(terminate_contract_suspensao_licitar).
action_label(terminate_contract_suspensao_licitar, 'Terminate contract suspensao licitar').
action_type(terminate_contract_suspension).
action_label(terminate_contract_suspension, 'Terminate contract after suspension').
action_type(uninstall_infrastructure).
action_label(uninstall_infrastructure, 'Uninstall infrastructure').

% ===== 3) Original Contract ABox =====
contract(contrato_ocs_112_2021).
contract_metadata(contrato_ocs_112_2021, numero_ocs, '112/2021').
contract_metadata(contrato_ocs_112_2021, numero_sap, '4400004652').
contract_metadata(contrato_ocs_112_2021, tipo_contrato, 'CONTRATO DE PRESTAÇÃO DE SERVIÇOS').
contract_metadata(contrato_ocs_112_2021, partes, ['BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES', 'OI S.A. - EM RECUPERACAO JUDICIAL']).
contract_metadata(contrato_ocs_112_2021, contratante, 'BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES').
contract_metadata(contrato_ocs_112_2021, contratado, 'OI S.A. EM RECUPERACAO JUDICIAL').
contract_metadata(contrato_ocs_112_2021, cnpj_contratante, '33.657.248/0001-89').
contract_metadata(contrato_ocs_112_2021, cnpj_contratado, '76.535.764/0001-43').
contract_metadata(contrato_ocs_112_2021, procedimento_licitatorio, 'Pregão Eletrônico nº 024/2021 - BNDES').
contract_metadata(contrato_ocs_112_2021, data_autorizacao, '03/05/2021').
contract_metadata_raw(contrato_ocs_112_2021, ip_ati_deset, '009/2021', 'trecho_literal').
contract_metadata(contrato_ocs_112_2021, data_ip_ati_degat, '27/04/2021').
contract_metadata(contrato_ocs_112_2021, rubrica_orcamentaria, '3101300003').
contract_metadata(contrato_ocs_112_2021, rubrica_orcamentaria, '3101300099').
contract_metadata(contrato_ocs_112_2021, centro_custo, 'BN00004000').
contract_metadata(contrato_ocs_112_2021, lei_aplicavel, 'Lei nº 13.303/2016').
contract_metadata(contrato_ocs_112_2021, regulamento, 'Regulamento Licitações e Contratos do Sistema BNDES').
contract_clause(contrato_ocs_112_2021, clausula_primeira_objeto, 'CLÁUSULA PRIMEIRA – OBJETO', 'O presente Contrato tem por objeto a prestação de serviço de comunicação de dados para acesso permanente, dedicado e exclusivo à rede da Agência de Notícias Bloomberg, incluindo a implantação e o remanejamento dos canais de comunicação de dados (Item I), conforme especificações constantes do Termo de Referência (Anexo I do Edital do Pregão Eletrônico nº 24/2021 - BNDES) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_112_2021, clausula_segunda_vigencia, 'CLÁUSULA SEGUNDA – VIGÊNCIA', 'O presente Contrato terá a duração da seguinte forma:  a) até 12 (doze) meses, contados da assinatura do contrato, no que concerne ao prazo para demanda pelo BNDES para início da implantação pela Contratada, bem como ao prazo para a implantação propriamente dita, incluindo todas as fases até a emissão do Termo de Recebimento da Implantação; e  b) até 60 (sessenta) meses, contados a partir da emissão do Termo de Recebimento Definitivo da Implantação, no que concerne ao serviço de comunicação de dados para acesso permanente, dedicado e exclusivo à rede da Agência de Notícias Bloomberg, incluindo o remanejamento dos canais de comunicação de dados, conforme consta nas Especificações Técnicas.').
contract_clause(contrato_ocs_112_2021, clausula_terceira_local_prazo_condicoes_execucao_objeto, 'CLÁUSULA TERCEIRA – LOCAL, PRAZO E CONDIÇÕES DE EXECUÇÃO DO OBJETO', 'A execução do objeto contratado respeitará as especificações constantes do Termo de Referência (Anexo I deste Contrato) e da proposta apresentada pelo CONTRATADO, respectivamente, Anexos I e II deste Contrato.').
contract_clause(contrato_ocs_112_2021, clausula_quarta_niveis_servico, 'CLÁUSULA QUARTA – NÍVEIS DE SERVIÇO', 'Os serviços contratados deverão ser executados de acordo com os padrões de qualidade, disponibilidade e desempenho estipulados pelo BNDES, observados os níveis de serviço descritos no Anexo I (Termo de Referência) deste Contrato.  Parágrafo Único O descumprimento dos níveis de serviço acarretará a aplicação dos índices de redução do preço previstos no Anexo I (Termo de Referência) deste Contrato, sem prejuízo da aplicação das penalidades previstas neste Contrato, quando cabíveis.').
contract_clause(contrato_ocs_112_2021, clausula_quinta_recebimento_objeto, 'CLÁUSULA QUINTA – RECEBIMENTO DO OBJETO', 'O BNDES efetuará o recebimento do objeto, através do Gestor, com o apoio do Fiscal do Contrato, mencionados na Cláusula de Obrigações do BNDES deste Contrato, observado o disposto no Anexo I (Termo de Referência) deste Contrato.').
contract_clause(contrato_ocs_112_2021, clausula_sexta_preco, 'CLÁUSULA SEXTA – PREÇO', 'O BNDES pagará ao CONTRATADO, pela execução do objeto contratado, o valor de até R$ 34.595,73 (trinta e quatro mil, quinhentos e noventa e cinco reais e setenta e três centavos), conforme proposta apresentada (Anexo II deste Contrato), observado o disposto na Cláusula de Pagamento deste Instrumento.   Parágrafo Primeiro No valor ajustado no caput desta Cláusula estão incluídos todos os insumos, encargos trabalhistas e tributos, inclusive contribuições fiscais e parafiscais, bem como quaisquer outras despesas necessárias à execução deste Contrato.  Parágrafo Segundo Na hipótese de o objeto ser, a critério do BNDES, parcialmente executado e recebido, os valores previstos nesta Cláusula serão proporcionalmente reduzidos, sem prejuízo da aplicação das penalidades cabíveis.  Parágrafo Terceiro Caso o BNDES não demande o total do objeto previsto neste Contrato, não será devida indenização ao CONTRATADO.   Parágrafo Quarto O CONTRATADO deverá arcar com os ônus decorrentes de eventual equívoco no dimensionamento dos quantitativos de sua proposta, devendo complementá-los, caso os quantitativos previstos inicialmente em sua proposta não sejam satisfatórios para o atendimento ao objeto deste Contrato.').
contract_clause(contrato_ocs_112_2021, clausula_setima_pagamento, 'CLÁUSULA SÉTIMA – PAGAMENTO', 'O BNDES efetuará o pagamento referente ao objeto deste Contrato, por meio de crédito em conta bancária, em até 10 (dez) dias úteis a contar da data de apresentação do documento fiscal ou equivalente legal (prioritariamente nota fiscal, e nos casos de dispensa da nota fiscal: fatura, boleto bancário com código de barras, recibo de pagamento a autônomo), desde que tenha sido efetuado ateste pelo Gestor do Contrato das obrigações contratuais assumidas pelo CONTRATADO, observado o disposto no Anexo I (Termo de Referência) deste Instrumento.  Parágrafo Primeiro O documento fiscal ou equivalente legal deverá ser apresentado ao BNDES no mês de sua emissão e até o dia 25 (vinte e cinco) do mesmo – ou data anterior que viabilize o tempestivo recolhimento de ISS, se a legislação tributária municipal incidente assim exigir – possibilitando o cumprimento, pelo BNDES, das obrigações fiscais principais e acessórias decorrentes deste Contrato. Havendo impedimento legal para o cumprimento desse prazo, o documento fiscal ou equivalente legal deverá ser apresentado até o primeiro dia útil do mês seguinte da prestação do serviço/fornecimento do bem.  Parágrafo Segundo A apresentação do documento de cobrança fora do prazo previsto nesta cláusula poderá implicar em sua rejeição e no direito do BNDES se ressarcir, preferencialmente, mediante desconto do valor a ser pago ao CONTRATADO, por qualquer penalidade tributária incidente pelo atraso.   Parágrafo Terceiro Nas hipóteses em que o recebimento definitivo ocorrer após a entrega do documento fiscal ou equivalente legal, o BNDES terá até 10 (dez) dias úteis, a contar da data em que o objeto tiver sido recebido definitivamente, para efetuar o pagamento.  Parágrafo Quarto O primeiro documento fiscal ou equivalente legal terá como objeto de cobrança o período compreendido entre o dia de início da prestação dos serviços e o último dia desse mês, e os documentos fiscais ou equivalentes legais subsequentes terão como referência o período compreendido entre o primeiro e o último dia de cada mês. O último documento fiscal ou equivalente legal, por seu turno, referir-se-á ao período compreendido entre o primeiro dia do último mês da prestação dos serviços e o último dia de serviço prestado. Em todos os casos, o documento fiscal ou equivalente legal só poderá ser emitido e apresentado ao BNDES após a efetiva prestação do serviço, respeitado o disposto no Parágrafo anterior.  Parágrafo Quinto Para toda efetivação de pagamento, o Contratado deverá encaminhar o documento fiscal ou equivalente em meio digital para caixa postal eletrônica ou protocolar em sistema eletrônico próprio do BNDES, considerando as orientações do Contratante vigentes na ocasião do pagamento. No caso de emissão de documento fiscal exclusivamente em meio físico o mesmo deverá ser encaminhado ao protocolo do BNDES para devido registro de recebimento.  Parágrafo Sexto O BNDES não efetuará pagamento diretamente em favor do(s) Subcontratado(s).   Parágrafo Sétimo O documento fiscal ou equivalente legal deverá respeitar a legislação tributária e conter, minimamente, as seguintes informações: I. número da Ordem de Compra/Serviço – OCS; II. número SAP do Contrato; III. número do pedido SAP, a ser informado pelo Gestor do Contrato; IV. número da Folha de Registro de Serviços (FRS), a ser informado pelo Gestor do Contrato; V. descrição detalhada do objeto executado e dos respectivos valores; VI. período de referência da execução do objeto; VII. nome e número do CNPJ do CONTRATADO, cuja regularidade fiscal tenha sido avaliada na fase de habilitação, bem como o número de inscrição na Fazenda Municipal e/ou Estadual, conforme o caso; VIII. nome, telefone e e-mail do responsável pelo documento fiscal ou equivalente legal; IX. nome e número do banco e da agência, bem como o número da conta corrente do CONTRATADO, vinculada ao CNPJ constante do documento fiscal ou equivalente legal, com respectivos dígitos verificadores; X. tomador do serviço: Banco Nacional de Desenvolvimento Econômico e Social – BNDES XI. CNPJ do tomador do serviço: 33.657.248/0001-89;  XII. local de execução do objeto, emitindo-se um documento fiscal ou equivalente legal para cada Município em que o serviço seja prestado, se for o caso;  XIII. código do serviço, nos termos da lista anexa à Lei Complementar nº 116/2003, em concordância com as informações inseridas na Declaração de Informações para Fornecimento - DIF;  XIV. número de inscrição do contribuinte individual válido junto ao INSS (NIT ou PIS/PASEP); e XV. destaque das retenções tributárias aplicáveis, conforme estabelecido na DIF.  Parágrafo Oitavo Os pagamentos a serem efetuados em favor do CONTRATADO estarão sujeitos, no que couber, às retenções de tributos, nos termos da legislação tributária e com base nas informações prestadas pelo CONTRATADO. Em casos de dispensa ou benefício fiscal que implique em redução ou eliminação da retenção de tributos, o CONTRATADO fornecerá todos os documentos comprobatórios.  Parágrafo Nono Caso o CONTRATADO emita documento fiscal ou equivalente legal autorizado por Município diferente daquele onde se localiza o estabelecimento do BNDES tomador do serviço e destinatário da cobrança, deverá providenciar o cadastro junto à Secretaria Municipal de Fazenda ou órgão equivalente do Município do estabelecimento tomador, salvo quando se aplicar uma das exceções constantes dos incisos do artigo 3º da Lei Complementar Federal nº 116/03.  A inexistência desse cadastro ou o cadastro em item diverso do faturado não constitui impeditivo ao processo de pagamento, mas um ônus a ser suportado pelo CONTRATADO, uma vez que o BNDES está obrigado a reter na fonte a quantia equivalente ao ISS dos serviços faturados, conforme legislação aplicável.  Parágrafo Décimo O documento fiscal ou equivalente legal emitido pelo CONTRATADO deverá estar em conformidade com a legislação do Município onde o CONTRATADO esteja estabelecida, cuja regularidade fiscal foi avaliada na etapa de habilitação, e com as normas regulamentares aprovadas pela Secretaria da Receita Federal do Brasil, especialmente no que tange à retenção de tributos, sob pena de devolução do documento e interrupção do prazo para pagamento.   Parágrafo Décimo Primeiro Ao documento fiscal ou equivalente legal deverão ser anexados: I. certidões de regularidade fiscal exigidas na fase de habilitação; II. comprovante de que o CONTRATADO é optante do Simples Nacional, se for o caso; III. em caso de isenção/imunidade tributária, documentos comprobatórios com a indicação do dispositivo legal que ampara a isenção/imunidade; e IV. demais documentos solicitados pelo Gestor do Contrato, necessários ao pagamento do objeto contratado;   Parágrafo Décimo Segundo Caso sejam verificadas divergências, o BNDES devolverá o documento fiscal ou equivalente legal ao CONTRATADO ou solicitará a emissão de carta de correção, quando cabível, interrompendo-se o prazo de pagamento até que este providencie as medidas saneadoras ou comprove a correção dos dados contestados pelo BNDES.   Parágrafo Décimo Terceiro Além de outras hipóteses previstas em lei ou no Contrato, o BNDES poderá descontar, do montante expresso no documento fiscal ou equivalente legal, os valores referentes a multas, indenizações apuradas em processo administrativo, bem como qualquer obrigação que decorra do descumprimento da legislação pelo CONTRATADO.  Parágrafo Décimo Quarto Caso o BNDES não efetue o pagamento na forma prevista nesta Cláusula, em decorrência de fato não atribuível ao CONTRATADO, aos valores devidos serão acrescidos juros de mora de 0,5% (meio por cento) ao mês, pro rata tempore, calculados desde o dia do vencimento até a data da efetiva liquidação.  Parágrafo Décimo Quinto Fica assegurado ao BNDES o direito de deduzir do pagamento devido ao CONTRATADO, por força deste Contrato ou de outro contrato mantido com o BNDES, o valor correspondente aos pagamentos efetuados a maior ou em duplicidade.').
contract_clause(contrato_ocs_112_2021, clausula_oitava_equilibrio_economico_financeiro_contrato, 'CLÁUSULA OITAVA – EQUILÍBRIO ECONÔMICO-FINANCEIRO DO CONTRATO', 'O BNDES e o CONTRATADO têm direito ao equilíbrio econômico-financeiro do Contrato, em consonância com o inciso XXI, do artigo 37, da Constituição Federal, a ser realizado mediante reajuste ou revisão de preços.  Parágrafo Primeiro O reajuste de preços, na forma prevista na legislação, poderá ser requerido pelo CONTRATADO a cada período de 12 (doze) meses, sendo o primeiro contado do dia 17/05/2021, data de apresentação da proposta (Anexo II deste Contrato), e os seguintes, do fato gerador anterior, adotando-se para tanto a aplicação do índice ICTI (Índice de Custo de Tecnologia da Informação) acumulado, sobre o preço referido na Cláusula de Preço deste Instrumento.  Parágrafo Segundo A revisão de preços poderá ser realizada por iniciativa do BNDES ou mediante solicitação do CONTRATADO, quando ocorrer fato imprevisível ou previsível, porém, de consequências incalculáveis, retardador ou impeditivo da execução do Contrato, ou ainda em caso de força maior, caso fortuito ou fato do príncipe, configurando álea econômica extraordinária e extracontratual, que onere ou desonere as obrigações pactuadas no presente Instrumento, sendo, porém, vedada nas hipóteses em que o risco seja alocado ao CONTRATADO nos termos da Cláusula de Matriz de Riscos, respeitando-se o seguinte:  I. o CONTRATADO deverá formular ao BNDES requerimento para a revisão do Contrato, comprovando a ocorrência do fato gerador; II. a comprovação será realizada por meio de documentos, tais como, atos normativos que criem ou alterem tributos, lista de preço de fabricantes, notas fiscais de aquisição de matérias-primas, de transporte de mercadorias, alusivas à época da elaboração da proposta ou do último reajuste e do momento do pedido de revisão; e III. com o requerimento, o CONTRATADO deverá apresentar planilhas de custos unitários, comparativas entre a data da formulação da proposta ou do último reajuste e o momento do pedido de revisão, contemplando os custos unitários envolvidos e evidenciando o quanto o aumento de preços ocorrido repercute no valor pactuado.  Parágrafo Terceiro Independentemente de solicitação, o BNDES poderá convocar o CONTRATADO para negociar a redução dos preços, mantendo o mesmo objeto contratado, na quantidade e nas especificações indicadas na proposta, em virtude da redução dos preços de mercado, ou de itens que compõem o custo, cabendo ao CONTRATADO apresentar as informações solicitadas pelo BNDES.   Parágrafo Quarto O CONTRATADO deverá solicitar o reajuste e/ou a revisão de preços até o encerramento do Contrato, hipótese em que os efeitos financeiros serão concedidos de modo retroativo a partir do fato gerador, observando-se, ainda, que: I. caso o fato gerador do reajuste e/ou da revisão de preços ou a divulgação do índice de reajuste ocorra com antecedência inferior a 60 (sessenta) dias do encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar do fato gerador ou da data de divulgação do índice, para solicitar o reajuste e/ou a revisão de preços; II. caso a divulgação do índice de reajuste ocorra após o encerramento do Contrato, o CONTRATADO terá o prazo de 60 (sessenta) dias, a contar da data de divulgação do índice, para solicitar o reajuste de preços; III. o BNDES deverá analisar o pedido de reajuste e/ou revisão de preços em até 60 (sessenta) dias, contados da solicitação e da entrega pelo CONTRATADO dos comprovantes de variação dos custos, ficando este prazo suspenso, a critério do BNDES, enquanto o CONTRATADO não apresentar a documentação solicitada para a comprovação da variação de custos; e IV. caso o CONTRATADO não solicite o reajuste e/ou revisão de preços nos prazos fixados acima, operar-se-á a renúncia a eventual direito ao reajuste e/ou à revisão.').
contract_clause(contrato_ocs_112_2021, clausula_nona_matriz_riscos, 'CLÁUSULA NONA – MATRIZ DE RISCOS', 'O BNDES e o CONTRATADO, tendo como premissa a obtenção do melhor custo contratual mediante a alocação do risco à parte com maior capacidade para geri-lo e absorvê-lo, identificam os riscos decorrentes da relação contratual e, sem prejuízo de outras previsões  contratuais, estabelecem os respectivos responsáveis na Matriz de Riscos constante do Anexo III deste Contrato.   Parágrafo Primeiro O reajuste de preço aludido na Matriz de Riscos deve respeitar o disposto na
contract_clause(contrato_ocs_112_2021, clausula_decima_garantia_contratual, 'CLÁUSULA DÉCIMA – GARANTIA CONTRATUAL', 'O CONTRATADO prestará, no prazo de até 10 (dez) dias úteis, contados da convocação, garantia contratual, sob pena de aplicação de penalidade nos termos deste Contrato, observadas as condições para sua aceitação estipuladas nos incisos abaixo, no valor de R$ 1.729,79 (um mil, setecentos e vinte e nove reais e setenta e nove centavos), que lhe será devolvida após a verificação do cumprimento fiel, correto e integral dos termos contratuais. I. Caução em dinheiro: deverá ser depositada em favor do BNDES, de acordo com as orientações que serão fornecidas quando da referida convocação; II. Seguro Garantia: a Apólice de Seguro deverá ser emitida por Instituição autorizada pela SUSEP a operar no mercado securitário, que não se encontre sob regime de Direção Fiscal, Intervenção, Liquidação Extrajudicial ou Fiscalização Especial, e que não esteja cumprindo penalidade de suspensão imposta pela SUSEP; a) O Instrumento de Apólice de Seguro deve prever expressamente: a.1) responsabilidade da seguradora por todas e quaisquer multas de caráter sancionatório aplicadas ao CONTRATADO; a.2) vigência pelo prazo contratual; a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação da expectativa de sinistro ou do efetivo aviso de sinistro, observados os prazos prescricionais pertinentes. III. Fiança Bancária: a Carta de Fiança deverá ser emitida por Instituição Financeira autorizada pelo Banco Central do Brasil - BACEN para funcionar no Brasil e que não se encontre em processo de liquidação extrajudicial ou de intervenção do BACEN. a) O Instrumento de Fiança deve prever expressamente: a.1) renúncia expressa, pelo fiador, ao benefício de ordem disposto no artigo 827 do Código Civil; a.2) vigência pelo prazo contratual;  a.3) prazo de 90 (noventa) dias, contados a partir do término da vigência contratual, para apuração de eventual inadimplemento do CONTRATADO - ocorrido durante a vigência contratual -, e para a comunicação do inadimplemento à Instituição Financeira, observados os prazos prescricionais pertinentes.  Parágrafo Primeiro O prazo previsto para a apresentação da garantia poderá ser prorrogado, por igual período, quando solicitado pelo CONTRATADO durante o respectivo transcurso, e desde que ocorra motivo justificado e aceito pelo BNDES.  Parágrafo Segundo Havendo majoração do preço contratado, decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, fica dispensada a atualização da garantia, salvo se o valor da atualização for igual ou superior ao patamar referenciado no inciso II do artigo 91 do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Terceiro Nos demais casos que demandem a complementação ou renovação da garantia, tais como alteração do objeto (aditivo quantitativo ou qualitativo), prorrogação contratual, dentre outros, o CONTRATADO deverá providenciá-la no prazo estipulado pelo BNDES.   Parágrafo Quarto Sempre que o contrato for garantido por fiança bancária ou seguro garantia, o CONTRATADO deve obter do garantidor anuência em relação à manutenção da garantia, no prazo de 10 (dez) dias úteis a contar da assinatura do aditivo ou recebimento de carta de apostilamento ou aditivo epistolar, conforme o caso. Recusando-se o garantidor a manter a garantia, cabe ao CONTRATADO obter nova garantia no mesmo prazo, prorrogável por igual período a critério do BNDES.').
contract_clause(contrato_ocs_112_2021, clausula_decima_primeira_obrigações_contratado, 'CLÁUSULA DÉCIMA PRIMEIRA – OBRIGAÇÕES DO CONTRATADO Além de outras obrigações estabelecidas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do CONTRATADO: I. manter durante a vigência deste Contrato todas as condições de habilitação exigidas quando da contratação, comprovando-as sempre que solicitado pelo BNDES; II. comunicar a imposição de penalidade que acarrete o impedimento de contratar com o BNDES, bem como a eventual perda dos pressupostos para a licitação; III. reparar, corrigir, remover, reconstruir ou substituir, às suas expensas, no total ou em parte, o objeto do Contrato em que se verificarem vícios, defeitos ou incorreções decorrentes da execução ou de materiais empregados;  IV. reparar todos os danos e prejuízos causados ao BNDES ou a terceiros, não restando excluída ou reduzida esta responsabilidade pela presença de fiscalização ou pelo acompanhamento da execução por parte do Gestor do Contrato; V. pagar todos os encargos e tributos, que incidam ou venham a incidir, direta ou indiretamente, sobre o objeto deste Contrato, podendo o BNDES, a qualquer momento, exigir do CONTRATADO a comprovação de sua regularidade; VI. assumir a responsabilidade integral por quaisquer ônus que venham a ser impostos ao BNDES em virtude de documento fiscal que seja emitido em desacordo com a legislação aplicável; VII. providenciar, perante a Receita Federal do Brasil - RFB, comprovando ao BNDES, sua exclusão obrigatória do Simples Nacional, no prazo estipulado pelo artigo 30 da Lei Complementar nº 123/2006, se o CONTRATADO, quando optante: a) extrapolar o limite de receita bruta anual previsto no artigo 3º da Lei Complementar nº 123/2006, ao longo da vigência deste Contrato; ou b) enquadrar-se em alguma das situações previstas no artigo 17 da Lei Complementar nº 123/2006; VIII. permitir vistorias e acompanhamento da execução do objeto pelo Gestor do Contrato; IX. obedecer às instruções e aos procedimentos, estabelecidos pelo BNDES, para a adequada execução do Contrato; X. designar 01 (um) preposto como responsável pelo Contrato firmado com o BNDES, para participar de eventuais reuniões e ser o interlocutor do CONTRATADO, zelando pelo fiel cumprimento das obrigações previstas neste Instrumento; XI. Manter organizados e devidamente identificados seus equipamentos e canais de comunicação, atendendo sempre às exigências técnicas necessárias à operação normal (chamado com Prioridade Nível 3, conforme a tabela do subitem 4.4.1.6 do Termo de Referência); e XII. A desinstalação da infraestrutura e retirada dos equipamentos de cada CONTRATADA, em fase posterior à de Implantação no endereço de origem é, em caso de Remanejamento, bem como no término da vigência contratual, de responsabilidade da CONTRATADA, e deverá ocorrer em até 30 (trinta) dias corridos após assinatura do respectivo Termo de Recebimento do Remanejamento ou do término da vigência contratual e mediante autorização específica emitida pelo BNDES. Convém ressaltar que, após o término deste prazo, o BNDES não mais se responsabiliza pela guarda destes equipamentos, bem como poderá aplicar a penalidade descrita no subitem 8.1.3. XIII. Proceder a novas instalações de canais de comunicação e outros serviços, que porventura sejam solicitados durante a vigência do CONTRATO, desde que estes sejam pertinentes ao objeto; XIV. Fornecer todas as informações necessárias para a utilização do serviço contratado pelo BNDES (chamado com Prioridade Nível 3, conforme a tabela do subitem 4.4.1.6);  XV.  Manter, durante toda a vigência do CONTRATO, o “escalation list” atualizada (chamado com Prioridade Nível 3, conforme a tabela do subitem 4.4.1.6); XVI. Informar o CPF, nome completo e informações para contato atualizadas acerca do preposto da CONTRATADA perante o BNDES (chamado com Prioridade Nível 3, conforme a tabela do subitem 4.4.1.6); XVII. Comunicar imediatamente ao BNDES qualquer anormalidade de caráter urgente e prestar os esclarecimentos necessários; XVIII. Identificar seus funcionários com crachás da empresa e informar os horários em que estes efetuarão serviços no BNDES, inclusive em relação aos da subcontratada; XIX. Durante a fase de encerramento do CONTRATO, atender a todas as solicitações do BNDES, relativas à implantação do novo serviço; XX. Impedir a participação, direta ou indireta, de empregado ou dirigente do BNDES e suas subsidiárias na execução do objeto do CONTRATO; XXI. Adotar, sempre que cabível, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição; XXII. Responsabilizar-se pelo cumprimento das normas de segurança das dependências do BNDES por parte dos seus profissionais e os da subcontratada alocados na execução dos serviços, quanto ao porte de identificação e à utilização dos acessos indicados pelo BNDES; XXIII. Devolver recursos disponibilizados pelo BNDES, revogar perfis de acesso de seus profissionais, eliminar suas caixas postais e adotar demais providências aplicáveis ao término da vigência do CONTRATO; XXIV. Assumir inteira responsabilidade técnica e administrativa em relação ao objeto contratado, não podendo, sob qualquer hipótese, transferir a outras empresas a responsabilidade por problemas na prestação dos serviços; XXV. Implantar, de forma adequada, a supervisão permanente dos serviços, de modo a obter uma operação correta e eficaz; XXVI. Manter sigilo relativamente ao objeto contratado, bem como sobre dados, documentos, especificações técnicas ou comerciais, não tornadas públicas pelo BNDES, de que venha a ter conhecimento em virtude da contratação, bem como a respeito da execução e resultados obtidos na prestação de serviços, inclusive após o término do prazo de vigência do CONTRATO, sendo vedada a divulgação dos referidos resultados a terceiros em geral, e em especial a quaisquer meios de comunicação públicos e/ou privados; XXVII.  Não efetuar a compilação reversa, montagem reversa ou engenharia reversa de qualquer programa aplicativo do BNDES ou de terceiros a que venha ter acesso por força do serviço; XXVIII. Indicar seus dados de endereço, telefone e endereço de e-mail, mantendo-os atualizados perante o BNDES durante toda a vigência do CONTRATO (chamado com Prioridade Nível 3, conforme a tabela do subitem 4.4.1.6);   XXIX. Notificar ao BNDES, por escrito, quaisquer fatos que possam pôr em risco a execução do presente objeto; XXX. Cumprir, durante a execução do Contrato, as leis federais, estaduais e municipais vigentes ou que entrarem em vigor, sendo a única responsável pelas infrações cometidas, convencionando-se, desde já, que o BNDES poderá descontar de qualquer crédito da CONTRATADA a importância correspondente a eventuais pagamentos desta natureza que venha efetuar por imposição legal; XXXII. apresentar, em até 10 dias úteis após a convocação, a Declaração de Informações para Fornecimento - DIF, adequadamente preenchida, sob pena de instauração de procedimento punitivo para aplicação de penalidade, e de retenção tributária, pelo BNDES, nos casos previstos em lei, da alíquota que entender adequada; a) as informações inseridas na Declaração de Informações para Fornecimento – DIF não deverão divergir das constantes do documento fiscal ou equivalente legal; XXXIV. garantir que o objeto do Contrato não infringe quaisquer direitos autorais, patentes ou registros, inclusive marcas, know-how ou trade-secrets, sendo responsável pelos prejuízos, inclusive honorários de advogado, custas e despesas decorrentes de qualquer medida ou processo judicial ou administrativo iniciado em face do BNDES, por acusação da espécie, podendo o CONTRATADO ser instado a intervir no processo.', 'trecho_literal').
contract_clause(contrato_ocs_112_2021, clausula_decima_segunda_conduta_ética_do_contratado_e_do_bndes, 'CLÁUSULA DÉCIMA SEGUNDA – CONDUTA ÉTICA DO CONTRATADO E DO BNDES O CONTRATADO e o BNDES comprometem-se a manter a integridade nas relações público-privadas, agindo de boa-fé e de acordo com os princípios da moralidade administrativa e da impessoalidade, além de pautar sua conduta por preceitos éticos e, em especial, por sua responsabilidade socioambiental.  Parágrafo Primeiro Em atendimento ao disposto no caput desta Cláusula, o CONTRATADO obriga-se, inclusive, a: I. não oferecer, prometer, dar, autorizar, solicitar ou aceitar, direta ou indiretamente, qualquer vantagem indevida, seja pecuniária ou de outra natureza, consistente em fraude, ato de corrupção ou qualquer outra violação de dever legal, relacionada com este Contrato, bem como a tomar todas as medidas ao seu alcance para impedir administradores, empregados, agentes, representantes, fornecedores, contratados ou subcontratados, seus ou de suas controladas, de fazê-lo; II. impedir o favorecimento ou a participação de empregado ou dirigente do Sistema BNDES (BNDES e suas subsidiárias) na execução do objeto do presente Contrato; III. providenciar para que não sejam alocados, na execução dos serviços, familiares de dirigente ou empregado do Sistema BNDES, considerando-se familiar o cônjuge, o companheiro ou o parente em linha reta ou colateral, por consanguinidade ou afinidade, até o terceiro grau;  IV. observar o Código de Ética do Sistema BNDES vigente ao tempo da contratação, bem como a Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e a Política Corporativa Anticorrupção do Sistema BNDES, assegurando-se de que seus representantes, administradores e todos os profissionais envolvidos na execução do objeto pautem seu comportamento e sua atuação pelos princípios neles constantes; e V. adotar, na execução dos serviços, boas práticas de sustentabilidade ambiental, de otimização de recursos, de redução de desperdícios e de redução da poluição.  Parágrafo Segundo O BNDES recomenda, ao CONTRATADO, considerar em suas práticas de gestão a implantação de programa de integridade estruturado, voltado à prevenção, detecção e remediação da ocorrência de fraudes e atos de corrupção.  Parágrafo Terceiro Verificada uma das situações mencionadas nos incisos II e III do Parágrafo Primeiro desta Cláusula, compete ao CONTRATADO afastar imediatamente da execução do Contrato os agentes que impliquem a ocorrência dos impedimentos e favorecimentos aludidos, além de comunicar tal fato ao BNDES, sem prejuízo de apuração de sua responsabilidade, caso tenha agido de má-fé.  Parágrafo Quarto O CONTRATADO declara ter conhecimento do Código de Ética do Sistema BNDES, bem como da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES e da Política Corporativa Anticorrupção do Sistema BNDES, que poderão ser consultados por intermédio do sítio eletrônico www.bndes.gov.br ou requisitados ao Gestor do Contrato.  Parágrafo Quinto Eventuais irregularidades ou descumprimentos das normas internas do BNDES ou da legislação vigente podem ser denunciados à Ouvidoria por qualquer cidadão através dos seguintes canais: página na internet (www.bndes.gov.br/ouvidoria); correio (Caixa Postal 15054, CEP 20031-120, Rio de Janeiro – RJ); e telefone (0800 702 6307).', 'trecho_literal').
contract_clause(contrato_ocs_112_2021, clausula_decima_terceira_sigilo_das_informações, 'CLÁUSULA DÉCIMA TERCEIRA – SIGILO DAS INFORMAÇÕES Caso o CONTRATADO venha a ter acesso a dados, materiais, documentos e informações de natureza sigilosa, direta ou indiretamente, em decorrência da execução do objeto contratual, deverá manter o sigilo dos mesmos, bem como orientar os profissionais envolvidos a cumprir esta obrigação, respeitando-se as diretrizes e normas da Política Corporativa de Segurança da Informação do BNDES.     Parágrafo Único Assim que solicitado pelo Gestor do Contrato, o CONTRATADO deverá providenciar a assinatura, por seu representante legal e pelos profissionais que tiverem acesso a informações sigilosas, dos Termos de Confidencialidade a serem disponibilizados pelo BNDES.', 'trecho_literal').
contract_clause(contrato_ocs_112_2021, clausula_decima_quarta_acesso_protecao_dados_pessoais, 'CLÁUSULA DÉCIMA QUARTA – ACESSO E PROTEÇÃO DE DADOS PESSOAIS', 'As partes assumem o compromisso de proteger os direitos fundamentais de liberdade e de privacidade, relativos ao tratamento de dados pessoais, nos meios físicos e digitais, devendo, para tanto, adotar medidas corretas de segurança sob o aspecto técnico, jurídico e administrativo, e observar que:   I. Eventual tratamento de dados em razão do presente Contrato deverá ser realizado conforme os parâmetros previstos na legislação, especialmente na Lei n° 13.709/2018 – Lei Geral de Proteção de Dados - LGPD, dentro de propósitos legítimos, específicos, explícitos e informados ao titular;   II. O tratamento será limitado às atividades necessárias ao atingimento das finalidades contratuais e, caso seja necessário, ao cumprimento de suas obrigações legais ou regulatórias, sejam de ordem principal ou acessória, observando-se que, em caso de necessidade de coleta de dados pessoais, esta será realizada mediante prévia aprovação do BNDES, responsabilizando-se o CONTRATADO por obter o consentimento dos titulares, salvo nos casos em que a legislação dispense tal medida;  III. O CONTRATADO deverá seguir as instruções recebidas do BNDES em relação ao tratamento de dados pessoais;  IV. O CONTRATADO se responsabilizará como “Controlador de dados” no caso do tratamento de dados para o cumprimento de suas obrigações legais ou regulatórias, devendo obedecer os parâmetros previstos na legislação;  V. Os dados coletados somente poderão ser utilizados pelas partes, seus representantes, empregados e prestadores de serviços diretamente alocados na execução contratual, sendo que, em hipótese alguma, poderão ser compartilhados ou utilizados para outros fins, sem a prévia autorização do BNDES, ou caso haja alguma ordem judicial, observando-se as medidas legalmente previstas para tanto;  VI. O CONTRATADO deve manter a confidencialidade dos dados pessoais obtidos em razão do presente contrato, devendo adotar as medidas técnicas e administrativas adequadas e necessárias, visando assegurar a proteção dos dados, nos termos do artigo 46 da LGPD, de modo a garantir um nível apropriado de segurança e a prevenção e mitigação de eventuais riscos;   VII. Os dados deverão ser armazenados de maneira segura pelo CONTRATADO, que utilizará recursos de segurança da informação e tecnologia adequados, inclusive quanto a mecanismos de detecção e prevenção de ataques cibernéticos e incidentes de segurança da informação.   VIII. O CONTRATADO dará conhecimento formal para seus empregados e/ou prestadores de serviço acerca das disposições previstas nesta Cláusula e na Cláusula de Sigilo das Informações, responsabilizando-se por eventual uso indevido dos dados pessoais, bem como por quaisquer falhas nos sistemas por ela empregados para o tratamento dos dados.  IX. O BNDES possui direito de regresso em face do CONTRATADO em razão de eventuais danos causados por este em decorrência do descumprimento das responsabilidades e obrigações previstas no âmbito deste contrato e da Lei Geral de Proteção de Dados Pessoais;  X. O CONTRATADO deverá disponibilizar ao titular do dado um canal ou sistema em que seja garantida consulta facilitada e gratuita sobre a forma, a duração do tratamento e a integralidade de seus dados pessoais.  XI. O CONTRATADO deverá informar imediatamente ao BNDES todas as solicitações recebidas em razão do exercício dos direitos pelo titular dos dados relacionados a este Contrato, seguindo as orientações fixadas pelo BNDES e pela legislação em vigor para o adequado endereçamento das demandas.  XII. O CONTRATADO deverá manter registro de todas as operações de tratamento de dados pessoais que realizar no âmbito do Contrato disponibilizando, sempre que solicitado pelo BNDES, as informações necessárias à produção do Relatório de Impacto de Dados Pessoais, disposto no artigo 5º, XVII, da Lei Geral de Proteção de Dados Pessoais..  XIII. Qualquer incidente que implique em violação ou risco de violação ou vazamento de dados pessoais deverá ser prontamente comunicado ao BNDES, informando-se também todas as providências adotadas e os dados pessoais eventualmente afetados, cabendo ao CONTRATADO disponibilizar as informações e documentos solicitados e colaborar com qualquer investigação ou auditoria que venha a ser realizada.  XIV. Ao final da vigência do Contrato, o CONTRATADO deverá eliminar de sua base de informações todo e qualquer dado pessoal que tenha tido acesso em razão da execução do objeto contratado, salvo quando tenha que manter a informação para o cumprimento de obrigação legal.  Parágrafo Primeiro  As Partes reconhecem que, se durante a execução do Contrato armazenarem, coletarem, tratarem ou de qualquer outra forma processarem dados pessoais, no sentido dado pela legislação vigente aplicável, o BNDES será considerado “Controlador de Dados”, e o CONTRATADO “Operador” ou “Processador de Dados”, salvo nas situações expressas em  contrário nesse Contrato. Contudo, caso o CONTRATADO descumpra as obrigações prevista na legislação de proteção de dados ou as instruções do BNDES, será equiparado a “Controlador de Dados”, inclusive para fins de sua responsabilização por eventuais danos causados.  Parágrafo Segundo Caso o CONTRATADO disponibilize dados de terceiros, além das obrigações no caput desta Cláusula, deve se responsabilizar por eventuais danos que o BNDES venha a sofrer em decorrência de uso indevido de dados pessoais por parte do CONTRATADO, sempre que ficar comprovado que houve falha de segurança técnica e administrativa, descumprimento de regras previstas na legislação de proteção à privacidade e dados pessoais, e das orientações do BNDES, sem prejuízo das penalidades deste contrato.  Parágrafo Terceiro A transferência internacional de dados deve se dar em caráter excepcional e na estrita observância da legislação, especialmente, dos artigos 33 a 36 da Lei n° 13.709/2018 e nos normativos do Banco Central do Brasil relativos ao processamento e armazenamento de dados das instituições financeiras, e dependerá de autorização prévia do BNDES ao CONTRATADO.').
contract_clause(contrato_ocs_112_2021, clausula_decima_quinta_obrigações_bndes, 'CLÁUSULA DÉCIMA QUINTA – OBRIGAÇÕES DO BNDES', 'Além de outras obrigações estipuladas neste Instrumento, em seus anexos ou nas leis vigentes, particularmente na Lei nº 13.303/2016, ou que entrarem em vigor, constituem obrigações do BNDES: I. realizar os pagamentos devidos ao CONTRATADO, nas condições estabelecidas neste Contrato; II. designar, como Gestor do Contrato, José Wilson Freire, empregado da ATI/DESET/GINF, a quem caberá o acompanhamento, a fiscalização e a avaliação da execução dos serviços, bem como a liquidação da despesa e o atestado de cumprimento das obrigações assumidas; III. alterar, quando conveniente, o Gestor do Contrato e/ou o seu substituto, por outro profissional, mediante comunicação escrita ao CONTRATADO; IV. designar o Fiscal do Contrato que auxiliará o Gestor do Contrato no acompanhamento, na fiscalização e na avaliação da execução do objeto;  V. designar a Comissão de Recebimento, a quem caberá dar suporte ao gestor para o recebimento do objeto;  VI. fornecer ao CONTRATADO, quando solicitado ao Gestor do Contrato, cópia do Código de Ética do Sistema BNDES, da Política de Conduta e de Integridade das Licitações e Contratos Administrativos do Sistema BNDES, da Política Corporativa Anticorrupção do Sistema BNDES e da Política Corporativa de Segurança da Informação do BNDES; VII. colocar à disposição do CONTRATADO todas as informações necessárias à perfeita execução dos serviços objeto deste Contrato; e  VIII. comunicar ao CONTRATADO, por escrito:  a) quaisquer instruções ou procedimentos sobre assuntos relacionados ao Contrato; b) a abertura de procedimento administrativo para a apuração de condutas irregulares do CONTRATADO, concedendo-lhe prazo para defesa; e c) a aplicação de eventual penalidade, nos termos deste Contrato.').
contract_clause(contrato_ocs_112_2021, clausula_decima_sexta_cessao_contrato_credito_sucessao_subcontratacao, 'CLÁUSULA DÉCIMA SEXTA – CESSÃO DE CONTRATO OU DE CRÉDITO, SUCESSÃO CONTRATUAL E SUBCONTRATAÇÃO', 'É vedada a cessão deste Contrato, total ou parcialmente, ou de qualquer crédito dele decorrente, bem como a emissão, por parte do CONTRATADO, de qualquer título de crédito em razão do mesmo.  Parágrafo Primeiro É admitida a sucessão contratual nas hipóteses em que o CONTRATADO realizar as operações societárias de fusão, cisão ou incorporação, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal alteração contratual; e II. manutenção de todas as condições contratuais e requisitos de habilitação originais.  Parágrafo Segundo Caso ocorra a sucessão contratual admitida no Parágrafo anterior, o sucessor assumirá integralmente a posição do sucedido, passando a ser responsável pela execução do presente Contrato, fazendo, por conseguinte, jus ao recebimento dos créditos dele decorrentes.  Parágrafo Terceiro É admitida a subcontratação da parcela do objeto deste Contrato referente à última milha, condicionada aos seguintes requisitos: I. aquiescência prévia do BNDES, que analisará eventuais riscos ou prejuízos decorrentes de tal operação; e II. atendimento de todas as condições contratuais e requisitos para a subcontratação previstos no Edital e no Termo de Referência (Anexo I deste Contrato), cabendo ao CONTRATADO apresentar, sempre que solicitado pelo BNDES, os respectivos documentos comprobatórios.  Parágrafo Quarto A subcontratação pode ser realizada com sociedades distintas e de forma simultânea, devendo, em todos os casos, ser relacionada à parcela do objeto autorizada pelo BNDES.     Parágrafo Quinto Caso o CONTRATADO opte por subcontratar o objeto deste Contrato, permanecerá como responsável perante o BNDES pela adequada execução do ajuste, sujeitando-se, inclusive, às penalidades previstas neste Contrato, na hipótese de não cumprir as obrigações ora pactuadas, ainda que por culpa da sociedade subcontratada.  Parágrafo Sexta Aceita, pelo BNDES, a subcontratação, o CONTRATADO deverá apresentar os Termos de Confidencialidade, conforme minuta constante do Anexo IV (Minuta de Termo de Confidencialidade para Subcontratação) deste Contrato, assinados pelo representante legal e pelos profissionais da sociedade subcontratada envolvidos na execução dos serviços subcontratados.').
contract_clause(contrato_ocs_112_2021, clausula_decima_setima_penalidades, 'CLÁUSULA DÉCIMA SÉTIMA – PENALIDADES', 'Em caso de inexecução total ou parcial do Contrato, inclusive de descumprimento de exigência expressamente formulada pelo BNDES ou de inobservância de qualquer obrigação legal, bem como em caso de mora, sem motivo justificado, o CONTRATADO ficará sujeito às seguintes penalidades: I. advertência; II. multa, de acordo com o Anexo I (Termo de Referência); e III. suspensão temporária de participação em licitação e impedimento de contratar com o BNDES, por prazo não superior a 2 (dois) anos, apurado de acordo com a gravidade da infração.  Parágrafo Primeiro As penalidades serão aplicadas observadas as normas do Regulamento de Licitações e Contratos do SISTEMA BNDES.   Parágrafo Segundo  Contra a decisão de aplicação de penalidade, o CONTRATADO poderá requerer a reconsideração para a decisão de advertência, ou interpor o recurso cabível para as demais penalidades, na forma e no prazo previstos no Regulamento de Licitações e Contratos do SISTEMA BNDES.  Parágrafo Terceiro  A imposição de penalidade prevista nesta Cláusula não impede a extinção do Contrato pelo BNDES, nos termos da legislação aplicável e da Cláusula de Extinção do Contrato.   Parágrafo Quarto  A multa poderá ser aplicada juntamente com as demais penalidades.     Parágrafo Quinto  A multa aplicada ao CONTRATADO e os prejuízos causados ao BNDES serão deduzidos de quaisquer créditos a ele devidos, assim como da garantia prestada, ressalvada a possibilidade de cobrança judicial da diferença eventualmente não coberta pelos mencionados créditos.  Parágrafo Sexto  No caso de atos lesivos à Administração Pública, nacional ou estrangeira, observar-se-ão os termos da Lei nº 12.846/2013.  Parágrafo Sétimo A celebração de Termo de Ajustamento de Conduta prevista no Regulamento de Licitações e Contratos do Sistema BNDES não importa em renúncia às penalidades prevista neste Contrato e no Anexo I (Termo de Referência).  Parágrafo Oitavo A sanção prevista no inciso III desta Cláusula também poderá ser aplicada às sociedades ou profissionais que: I. tenham sofrido condenação definitiva por praticarem, por meios dolosos, fraude fiscal no recolhimento de quaisquer tributos; II. tenham praticado atos ilícitos visando frustrar os objetivos da licitação; III. demonstrem não possuir idoneidade para contratar com o BNDES em virtude de atos ilícitos praticados.').
contract_clause(contrato_ocs_112_2021, clausula_decima_oitava_alteracoes_contratuais, 'CLÁUSULA DÉCIMA OITAVA – ALTERAÇÕES CONTRATUAIS', 'O presente Contrato poderá ser alterado, por acordo entre as partes, nas hipóteses disciplinadas no art. 81 da Lei nº 13.303/2016, entre outras legal ou contratualmente previstas, observando-se que:  I. as alterações devem preservar o equilíbrio econômico-financeiro do Contrato; e II. é vedada a modificação contratual que desnature o objeto da contratação ou afete as condições essenciais previstas no Termo de Referência (Anexo I deste Contrato).  Parágrafo Primeiro Em atenção aos princípios que regem as relações contratuais, nas hipóteses em que for imprescindível a alteração deste Contrato para viabilizar sua plena execução, conforme demonstrado em processo administrativo, não caberá a recusa das partes à respectiva formalização, salvo em caso de justo motivo, devidamente comprovado pela parte que o alegar.  Parágrafo Segundo       A parte que, injustificadamente, se recusar a promover a alteração contratual indicada no  Parágrafo anterior, deverá responder pelos danos eventualmente causados, sem prejuízo das demais consequências previstas neste Instrumento e na legislação vigente.     Parágrafo Terceiro As alterações contratuais serão formalizadas mediante instrumento aditivo, ressalvadas as hipóteses legais que admitem a alteração por apostilamento, os ajustes necessários à eventual correção de erros materiais ou à alteração de dados acessórios do Contrato e alterações de preços decorrentes decorrente de reajuste, repactuação ou revisão de preços causada por alterações na legislação tributária, que poderão ser celebrados por meio epistolar.').
contract_clause(contrato_ocs_112_2021, clausula_decima_nona_extincao_contrato, 'CLÁUSULA DÉCIMA NONA – EXTINÇÃO DO CONTRATO', 'O presente Contrato poderá ser extinto de acordo com as hipóteses previstas na legislação, e ainda: I. Consensualmente, formalizada em autorização escrita e fundamentada do BNDES, mediante aviso prévio por escrito, com antecedência mínima de 90 (noventa) dias ou de prazo menor a ser negociado pelas partes à época da rescisão; II. em razão do inadimplemento total ou parcial de qualquer de suas obrigações, cabendo à parte inocente notificar a outra por escrito, assinalando-lhe prazo razoável para o cumprimento das obrigações, quando o mesmo não for previamente fixado neste instrumento ou em seus anexos; II. na ausência de liberação, por parte do BNDES, de área, local ou objeto necessário para a sua execução, nos prazos contratuais; III. em virtude da suspensão da execução do Contrato, por ordem escrita do BNDES, por prazo superior a 120 (cento e vinte) dias ou ainda por repetidas suspensões que totalizem o mesmo prazo;  IV. quando for decretada a falência do CONTRATADO; V. caso o CONTRATADO perca uma das condições de habilitação exigidas quando da contratação; VI. na hipótese de descumprimento do previsto na Cláusula de Cessão de Contrato ou de Crédito, Sucessão Contratual e Subcontratação; VII. caso o CONTRATADO seja declarada inidônea pela União, por Estado ou pelo Distrito Federal;  VIII. em função da suspensão do direito de o CONTRATADO licitar ou contratar com o BNDES; IX. na hipótese de caracterização de ato lesivo à Administração Pública, nos termos da Lei nº 12.846/2013, cometido pelo CONTRATADO no processo de contratação ou por ocasião da execução contratual; X. em razão da dissolução do CONTRATADO;  XI. quando da ocorrência de caso fortuito ou de força maior, regularmente comprovado,  impeditivo da execução do Contrato; e  Parágrafo Primeiro Caracteriza inadimplemento das obrigações de pagamento pecuniário do presente Contrato, a mora superior a 90 (noventa) dias.  Parágrafo Segundo Os casos de extinção contratual convencionados no caput desta Cláusula deverão ser precedidos de notificação escrita à outra parte do Contrato, e de oportunidade de defesa, dispensada a necessidade de interpelação judicial.').
contract_clause(contrato_ocs_112_2021, clausula_vigesima_disposicoes_finais, 'CLÁUSULA VIGÉSIMA – DISPOSIÇÕES FINAIS', 'Este Contrato representa todo o acordo entre as partes com relação ao objeto nele previsto.   Parágrafo Primeiro Integram o presente Contrato: Anexo I - Termo de Referência do Pregão Eletrônico nº 024/2021 - BNDES Anexo II - Proposta Anexo III - Matriz de Risco Anexo IV - Termo de Confidencialidade para Representante Legal Anexo V - Minuta de Termo de Confidencialidade para Profissionais Anexo VI - Minuta de Termo de Confidencialidade para Subcontratação  Parágrafo Segundo A omissão ou tolerância quanto à exigência do estrito cumprimento das obrigações contratuais ou ao exercício de prerrogativa decorrente deste Contrato não constituirá renúncia ou novação nem impedirá as partes de exercerem os seus direitos a qualquer tempo.').
contract_clause(contrato_ocs_112_2021, clausula_vigesima_primeira_foro, 'CLÁUSULA VIGÉSIMA PRIMEIRA – FORO', 'É competente o foro da cidade do Rio de Janeiro para solucionar eventuais litígios decorrentes deste Contrato, afastado qualquer outro, por mais privilegiado que seja.  E por estarem justos e contratados, firmam o presente para um só efeito. A assinatura dos representantes do BNDES e dos representantes do CONTRATADO se dará de forma digital.   As folhas deste Contrato foram conferidas por Ana Paula Soeiro de Britto, advogada do BNDES, apenas para a verificação de sua redação, por autorização do representante legal que o assina.  Reputa-se celebrado o presente contrato na data em que for registrada a última assinatura dos representantes do BNDES.   FOLHA DE ASSINATURA DO CONTRATO OCS 112/2021       _____________________________________________________________________ BANCO NACIONAL DE DESENVOLVIMENTO ECONÔMICO E SOCIAL – BNDES       _____________________________________________________________________ OI S.A. - EM RECUPERACAO JUDICIAL    Testemunhas:   _________________________________ _________________________________     JEAN SILVA:05487318611Assinado de forma digital por JEAN SILVA:05487318611 Dados: 2021.07.13 14:10:03 -03\'00\'SIGNREJANE TAVARES DA SILVA:78854130125Assinado de forma digital por REJANE TAVARES DA SILVA:78854130125 Dados: 2021.07.13 14:13:10 -03\'00\'HERILMAR POMPERMAYER FREIRE:00181257785Assinado de forma digital por HERILMAR POMPERMAYER FREIRE:00181257785 Dados: 2021.07.19 19:25:48 -03\'00\'FERNANDO PASSERI LAVRADO:00486757765Assinado de forma digital por FERNANDO PASSERI LAVRADO:00486757765 Dados: 2021.07.20 10:27:55 -03\'00\'EMMANUEL COUTO SILVA:01320487440Assinado de forma digital por EMMANUEL COUTO SILVA:01320487440 Dados: 2021.07.20 11:45:15 -03\'00\'FLAVIA DUARTE CUPELLO:89164687791Assinado de forma digital por FLAVIA DUARTE CUPELLO:89164687791 Dados: 2021.07.20 12:44:28 -03\'00\'').

% ===== END =====
